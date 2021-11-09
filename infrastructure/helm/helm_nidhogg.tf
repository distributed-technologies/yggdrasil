resource "helm_release" "nidhogg" {
  name              = "nidhogg"
  chart             = "../../nidhogg"
  dependency_update = true
  timeout = 600
}
