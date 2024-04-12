import json
import os
import regex

pattern_for_json_substring = regex.compile(r'\{(?:[^{}]|(?R))*\}')


def read_file(folder, sub_folder_name, filename):
    filepath = os.path.join(folder, sub_folder_name, filename)
    file = open(filepath, "r")
    content = file.read()
    file.close()
    return content


def read_json_file(folder, sub_folder_name, filename):
    filepath = os.path.join(folder, sub_folder_name, filename)
    content = {}
    with open(filepath) as json_file:
        content = json.load(json_file)
    return content


# Read results (custodian-run.log, metadata.json, resource.json) and put into array
def create_report(policy_execution_outputs: dict,
                  output_dir: str,
                  infra_color: str,
                  cloud: str):
    # Declare vars
    OUTPUT_DIR = output_dir
    detailed_report = []
    policy_execution_outputs_test = policy_execution_outputs.copy()

    for region in os.listdir(OUTPUT_DIR):
        current_path = os.path.join(OUTPUT_DIR, region)
        if os.path.isdir(current_path):
            for subfolder_name in os.listdir(current_path):
                if not os.path.isdir(os.path.join(current_path, subfolder_name)):
                    continue
                custodian_run = ""
                metadata = {}
                resources = []
                try:
                    custodian_run = read_file(current_path, subfolder_name, 'custodian-run.log')
                except Exception:
                    pass
                try:
                    metadata = read_json_file(current_path, subfolder_name, 'metadata.json')
                except Exception:
                    pass
                try:
                    resources = read_json_file(current_path, subfolder_name, 'resources.json')
                except Exception:
                    pass
                if custodian_run:
                    entity = {
                        "custodian-run": custodian_run,
                        "metadata": metadata,
                        "resources": resources,
                        "region": region
                    }
                    detailed_report.append(entity)
                    policy_name = metadata["policy"]["name"]
                    if policy_name in policy_execution_outputs.keys():
                        policy_execution_outputs.pop(policy_name)

    # Including results with errors
    for policy_name in policy_execution_outputs.keys():
        output = policy_execution_outputs[policy_name]['scan_result']
        policy_strings = pattern_for_json_substring.findall(output)
        policy = {"name": policy_name}
        if len(policy_strings) > 0:
            try:
                policy = json.loads(policy_strings[0])
            except Exception as e:
                pass
        if len(policy_strings) > 0:
            output = output.replace(policy_strings[0], '')
        output_list = output.split("\n")
        output_list = [output for output in output_list if output.strip() != ""]

        entity = {
            "custodian-run": "\n".join(output_list),
            "metadata": {'policy': policy},
            "resources": [],
            "errors": output_list
        }
        if 'region' in policy_execution_outputs[policy_name]:
            entity['region'] = policy_execution_outputs[policy_name]['region']

        detailed_report.append(entity)

    # Create report
    report = []
    for detailed_entity in detailed_report:
        detailed_custodian_run_log = detailed_entity["custodian-run"]
        detailed_metadata = detailed_entity["metadata"]
        detailed_resources = detailed_entity["resources"]
        detailed_errors = detailed_entity.get("errors", [])
        detailed_region = detailed_entity.get("region")

        policy = detailed_metadata["policy"]
        policy_resource = policy.get("resource", "")
        # policy_metadata = policy.get("metadata", {})
        # report_fields = policy_metadata.get("report_fields")
        if detailed_custodian_run_log.find("ERROR") > -1:
            run_result = "Errors were found"
            detailed_errors = detailed_custodian_run_log
        else:
            run_result = "No errors"
        resources = []
        # try:
        #     key_report = report_fields[0] if report_fields else None
        #     if key_report:
        #         detailed_resources = sorted(detailed_resources, key=lambda d: d[key_report])
        # except Exception:
        #     pass
        for detailed_resource in detailed_resources:
            resources.append(detailed_resource)
            # resource = {}
            # for key in detailed_resource:
                # # if report_fields:
                # #     if key in report_fields:
                # #         resource[key] = detailed_resource.get(key)
                # #     continue
                # current_resource = detailed_resource[key]
                # if isinstance(current_resource, (str, int, float)):
                #     resource[key] = current_resource
                # elif policy_resource.startswith("gcp."):
                #     if type(current_resource) is dict:
                #         for inner_key in current_resource.keys():
                #             resource[key + "_" + inner_key] = current_resource[inner_key]
                #     elif type(current_resource) is list:
                #         if len(current_resource) > 0 and type(current_resource[0]) is not dict:
                #             resource[key] = "\n".join(current_resource)
            # resources.append(resource if resource else detailed_resource)

        entity = {
            "policy_name": policy.get("name", ""),
            "description": policy.get("description", "no description"),
            "run_result": run_result,
            "resources #": len(resources),
            "region": detailed_region,
            "resources": resources,
            "errors": [detailed_errors]
        }
        # add errors if resource was not found in the custodian scan results
        resource_found = False
        tf_resource_name = policy_execution_outputs_test[entity['policy_name']]['name']
        with open(cloud.lower() + '_map_report_fields.json', 'r') as file:
            map_report_fields = json.load(file)
        resource_field = map_report_fields[policy_execution_outputs_test[entity['policy_name']]['policy_resource']]
        resource_field_value = ""
        if isinstance(tf_resource_name, str):
            tf_resource_name = [tf_resource_name]
        elif isinstance(tf_resource_name, list):
            tf_resources = tf_resource_name.copy()
            tf_resource_name_status = {r: False for r in tf_resource_name}
            for resource in entity["resources"]:
                if len(resource_field) > 1:
                    resource_field_value = {r: resource[r] for r in resource_field}
                else:
                    resource_field_value = resource[resource_field[0]]
                for tf_resource in tf_resources:
                    if isinstance(resource_field_value, str):
                        if tf_resource == resource_field_value and tf_resource:
                            tf_resource_name_status[tf_resource] = True
                            tf_resources.remove(tf_resource)
                            break
                    elif isinstance(resource_field_value, dict):
                        pass

                if all(value is True for value in tf_resource_name_status.values()):
                    break
        elif isinstance(tf_resource_name, dict):
            # tf_resources = tf_resource_name.copy()
            if isinstance(list(tf_resource_name.values())[0], str) and len(resource_field) > 1:
                tf_resource_name_status = {r: False for r in tf_resource_name}
                resource_field_values = {}
                for resource_field_name in resource_field:
                    resource_field_values[resource_field_name] = resource[resource_field_name]
            else:
                print("Wrong terraform output format!")


            #
            # elif isinstance(list(tf_resource_name.values())[0], list):
            #     pass

        else:
            print("Wrong format!")

        resource_found = all(value is True for value in tf_resource_name_status.values())
        if infra_color == "red":
            if not resource_found and tf_resource_name:
                not_found_resources = [k for k, v in tf_resource_name_status.items() if v is False]
                entity["errors"].append("ERROR - Error while testing found results.\n"
                                        f"The created terraform {infra_color} resource ({', '.join(not_found_resources)}) was not found in the custodian scan results")
        elif infra_color == "green":
            if any(value is True for value in tf_resource_name_status.values()) and tf_resource_name:
                not_found_resources = [k for k, v in tf_resource_name_status.items() if v is True]
                entity["errors"].append("ERROR - Error while testing found results.\n"
                                        f"The created terraform {infra_color} resource ({', '.join(not_found_resources)}) was found in the custodian scan results")
        if not tf_resource_name:
            entity["errors"].append("ERROR - Error while testing found results.\n"
                                    f"OUTPUT variable was not found")
        report.append(entity)
    

    failed = list()
    sorted_report = sorted(report, key=lambda x: x["policy_name"])
    for entity in sorted_report:
         # Create failed file
        if entity["errors"] and entity["errors"] != [[]]:
            error_message = f'{entity["policy_name"]}:' + entity["region"] if entity["region"] != "default" else ""
            for error in entity["errors"]:
                if error:  
                    error_message += f'\n{error}\n'
            failed.append(error_message)

    with open(os.path.join(OUTPUT_DIR, '.failed'), "w") as failed_file:
        for item in failed:
            failed_file.write(item + "\n")