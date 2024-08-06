########################
# CORE REDIS            #
########################
resource "helm_release" "transaction_redis" {
  chart      = "redis-ha"
  name       = "transaction"
  repository = "https://dandydeveloper.github.io/charts/"
  version    = var.redis_ha_version
  namespace  = var.pay_core_namespace

  cleanup_on_fail = true
}
