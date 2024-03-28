import timer
import subprocess
import json

# control text style
class Color:
    # text style
    RESET = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'

    # text color
    BLACK = '\033[30m'
    RED = '\033[31m'
    GREEN = '\033[32m'
    YELLOW = '\033[33m'


def auto_approve(path, verbosity=False, up=False, remove=False):
    command = f"cd {path} ; terraform {'apply' if up else 'destroy'} -auto-approve -no-color {'> /dev/null' if not verbosity else ''}"
    result = subprocess.run(command, shell=True, capture_output=True, text=True, check=True)
    state_list = subprocess.run(f"cd {path} ; terraform state list", shell=True, capture_output=True, text=True, check=True)
    print("list of active resources:\n", state_list.stdout if state_list.stdout else "No active resources")
    if up is not True and remove and result.returncode == 0:
        subprocess.run(f"cd {path} ; rm -rfv .terraform* terraform.tfstate*", shell=True, capture_output=True, text=True, check=True)



# Create/destroy terraform green/red infrastructure
@timer.time_decorator
def green_red_infrastructures_up_down(path, infra_color, up=False, down=False, verbosity=False, remove=False):
    try:
        color = infra_color

        print(f"{Color.GREEN + 3*'+' + Color.YELLOW + ' Up' if up else Color.RED + 3*'-' + Color.YELLOW + ' Down'}"
                  f"{Color.RED if color == 'red' else Color.GREEN} {color} {path}"
                  f"{'' if not verbosity else 'Full path: ' + Color.YELLOW + path} {Color.RESET}")
        if path is not None:
            if up:
                command = f"cd {path} ; terraform init -no-color {'> /dev/null' if not verbosity else ''}; \
                          terraform validate -no-color {'> /dev/null' if not verbosity else ''}; \
                          terraform fmt -no-color {'> /dev/null' if not verbosity else ''}"
                subprocess.run([command], shell=True, capture_output=True, text=True, check=True)
                auto_approve(path, verbosity=verbosity, up=up)
            elif down:
                auto_approve(path, verbosity=verbosity, remove=remove)
    except subprocess.CalledProcessError as error:
        return False, error.stderr
    return True, None


def output(path, policy_name, resource):
    # Run the Terraform command to get output in JSON format
    process = subprocess.Popen(['terraform', 'output', '-json'], stdout=subprocess.PIPE, stderr=subprocess.PIPE, cwd=f"{path}")
    output, error = process.communicate()

    # Check if there's any error
    if process.returncode != 0:
        raise RuntimeError(f"Terraform command failed with error: {error.decode()}")

    # Load the JSON output into a variable
    terraform_output = json.loads(output.decode())
    terraform_output = terraform_output[next(iter(terraform_output))]['value']
    name_prefix = ""
    if policy_name in terraform_output:
        name_prefix = terraform_output[policy_name]
    elif resource in terraform_output:
        name_prefix = terraform_output[resource]
    return name_prefix