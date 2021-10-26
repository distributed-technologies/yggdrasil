resource "helm_release" "nidhogg" {
  name = "nidhogg"
  chart = "../../nidhogg"
}
