output "route" {
  value = {
    route-table = aws_route_table.this.id
  }
}
