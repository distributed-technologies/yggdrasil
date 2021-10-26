resource "helm_release" "nidhogg" {
  depends_on = [
    module.kubernetes,
  ]

  name = "nidhogg"
  chart = "../nidhogg"
}
