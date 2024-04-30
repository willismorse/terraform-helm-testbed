
resource "helm_release" "dnsutils" {
  name      = "dnsutils-${var.namespace}"
  namespace = var.namespace
  chart     = "${path.module}/charts/dnsutils"
  version   = local.chart_versions_local.dnsutils
  values = [<<EOF

EOF
  ]
}
