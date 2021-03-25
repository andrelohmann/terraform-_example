locals {
  # workaround for multilayer inheritance in terragrunt (see https://github.com/gruntwork-io/terragrunt/issues/303)
  globals            = yamldecode(file(find_in_parent_folders("globals.yaml")))
  environment        = yamldecode(file(find_in_parent_folders("environment.yaml")))
  stage              = yamldecode(file(find_in_parent_folders("stage.yaml")))
  versions           = yamldecode(file(find_in_parent_folders("versions.yaml")))
  apigateway_commons = yamldecode(file(find_in_parent_folders("apigateway_commons.yaml")))

  # list containing "/" splitted path to the globals.yaml file of this repo
  globals_path_list = split("/", find_in_parent_folders("globals.yaml"))
  # string that direct to the absolute path of the root of this repo
  base_path = join("/", slice(local.globals_path_list, 0, length(local.globals_path_list) - 1))
  # path where all projects/repos are strored in. Used for easy local relative references to other repos
  project_path = "${local.base_path}/.."
}

terraform {
  source = local.globals.variables["debug_mode"] ? "${local.project_path}/productlake-terraform//layer/api-gateway/api" : "git::ssh://git@bitbucket.org/baldeney/productlake-terraform.git//layer/api-gateway/api${local.versions.variables["terraform_tag"]}"
}

dependency "api_global" {
  config_path = "../../global"
}

dependency "article_attribute_options" {
  config_path = "../../../lambda/endpoints/assets/article/attribute/OPTIONS"
}

dependency "article-bulk-patch" {
  config_path = "../../../lambda/endpoints/assets/article/bulk/PATCH"
}

dependency "article-bulk-post" {
  config_path = "../../../lambda/endpoints/assets/article/bulk/POST"
}

dependency "article_channellist_get" {
  config_path = "../../../lambda/endpoints/assets/article/channellist/GET"
}

dependency "article_classification_delete" {
  config_path = "../../../lambda/endpoints/assets/article/classification/DELETE"
}

dependency "article_classification_get" {
  config_path = "../../../lambda/endpoints/assets/article/classification/GET"
}

dependency "article_classification_options" {
  config_path = "../../../lambda/endpoints/assets/article/classification/OPTIONS"
}

dependency "article_classification_patch" {
  config_path = "../../../lambda/endpoints/assets/article/classification/PATCH"
}

dependency "article_classification_post" {
  config_path = "../../../lambda/endpoints/assets/article/classification/POST"
}

dependency "article_delete" {
  config_path = "../../../lambda/endpoints/assets/article/DELETE"
}

dependency "article_get" {
  config_path = "../../../lambda/endpoints/assets/article/GET"
}

dependency "article_list_get" {
  config_path = "../../../lambda/endpoints/assets/article/list/GET"
}

dependency "article_patch" {
  config_path = "../../../lambda/endpoints/assets/article/PATCH"
}

dependency "article_post" {
  config_path = "../../../lambda/endpoints/assets/article/POST"
}

dependency "article_quality_get" {
  config_path = "../../../lambda/endpoints/assets/article/quality/GET"
}

dependency "basic_auth" {
  config_path = "../../../lambda/authorizers/basicauth"
}

dependency "certificate" {
  config_path = "../../../dns/certificate/api-gateway"
}

dependency "channel_delete" {
  config_path = "../../../lambda/endpoints/assets/channel/DELETE"
}

dependency "channel_get" {
  config_path = "../../../lambda/endpoints/assets/channel/GET"
}

dependency "channel_patch" {
  config_path = "../../../lambda/endpoints/assets/channel/PATCH"
}

dependency "channel_post" {
  config_path = "../../../lambda/endpoints/assets/channel/POST"
}

dependency "filter-dictionary_delete" {
  config_path = "../../../lambda/endpoints/filter-dictionary/DELETE"
}

dependency "filter-dictionary_get" {
  config_path = "../../../lambda/endpoints/filter-dictionary/GET"
}

dependency "filter-dictionary_patch" {
  config_path = "../../../lambda/endpoints/filter-dictionary/PATCH"
}

dependency "filter-dictionary_post" {
  config_path = "../../../lambda/endpoints/filter-dictionary/POST"
}

dependency "notification_confirm_subscription_post" {
  config_path = "../../../lambda/endpoints/assets/notification/confirm-subscription/POST"
}

dependency "notification_subscribe_post" {
  config_path = "../../../lambda/endpoints/assets/notification/subscribe/POST"
}

dependency "notification_test_post" {
  config_path = "../../../lambda/endpoints/assets/notification/_test/POST"
}

dependency "notification_unsubscribe_post" {
  config_path = "../../../lambda/endpoints/assets/notification/unsubscribe/POST"
}

dependency "product_get" {
  config_path = "../../../lambda/endpoints/assets/product/GET"
}

dependency "product_list_get" {
  config_path = "../../../lambda/endpoints/assets/product/list/GET"
}

dependency "product_quality_get" {
  config_path = "../../../lambda/endpoints/assets/product/quality/GET"
}

dependency "release_article_candidate_get" {
  config_path = "../../../lambda/endpoints/release/article/candidate/GET"
}

dependency "release_article_candidate_post" {
  config_path = "../../../lambda/endpoints/release/article/candidate/POST"
}

dependency "release_article_get" {
  config_path = "../../../lambda/endpoints/release/article/GET"
}

dependency "release_article_post" {
  config_path = "../../../lambda/endpoints/release/article/POST"
}

dependency "release_article_quality_get" {
  config_path = "../../../lambda/endpoints/release/article/quality/GET"
}

dependency "system_get" {
  config_path = "../../../lambda/endpoints/system/GET"
}


inputs = merge(
  local.apigateway_commons.variables,
  {
    # manually entered attributes
    api_spec_replacements = {
      #LAMBDA_INVOCATION_ARN_MODEL_DELETE = dependency.model_delete.outputs.invoke_arn
      #LAMBDA_INVOCATION_ARN_MODEL_GET = dependency.model_get.outputs.invoke_arn
      #LAMBDA_INVOCATION_ARN_MODEL_POST = dependency.model_post.outputs.invoke_arn
      LAMBDA_INVOCATION_ARN_ARTICLE_ATTRIBUTE_OPTIONS              = dependency.article_attribute_options.outputs.invoke_arn
      LAMBDA_INVOCATION_ARN_ARTICLE_BULK_PATCH                     = dependency.article-bulk-patch.outputs.invoke_arn
      LAMBDA_INVOCATION_ARN_ARTICLE_BULK_POST                      = dependency.article-bulk-post.outputs.invoke_arn
      LAMBDA_INVOCATION_ARN_ARTICLE_CHANNELLIST_GET                = dependency.article_channellist_get.outputs.invoke_arn
      LAMBDA_INVOCATION_ARN_ARTICLE_CLASSIFICATION_DELETE          = dependency.article_classification_delete.outputs.invoke_arn
      LAMBDA_INVOCATION_ARN_ARTICLE_CLASSIFICATION_GET             = dependency.article_classification_get.outputs.invoke_arn
      LAMBDA_INVOCATION_ARN_ARTICLE_CLASSIFICATION_OPTIONS         = dependency.article_classification_options.outputs.invoke_arn
      LAMBDA_INVOCATION_ARN_ARTICLE_CLASSIFICATION_PATCH           = dependency.article_classification_patch.outputs.invoke_arn
      LAMBDA_INVOCATION_ARN_ARTICLE_CLASSIFICATION_POST            = dependency.article_classification_post.outputs.invoke_arn
      LAMBDA_INVOCATION_ARN_ARTICLE_DELETE                         = dependency.article_delete.outputs.invoke_arn
      LAMBDA_INVOCATION_ARN_ARTICLE_GET                            = dependency.article_get.outputs.invoke_arn
      LAMBDA_INVOCATION_ARN_ARTICLE_LIST_GET                       = dependency.article_list_get.outputs.invoke_arn
      LAMBDA_INVOCATION_ARN_ARTICLE_PATCH                          = dependency.article_patch.outputs.invoke_arn
      LAMBDA_INVOCATION_ARN_ARTICLE_POST                           = dependency.article_post.outputs.invoke_arn
      LAMBDA_INVOCATION_ARN_ARTICLE_QUALITY_GET                    = dependency.article_quality_get.outputs.invoke_arn
      LAMBDA_INVOCATION_ARN_BASIC_AUTH                             = dependency.basic_auth.outputs.invoke_arn
      LAMBDA_INVOCATION_ARN_CHANNEL_DELETE                         = dependency.channel_delete.outputs.invoke_arn
      LAMBDA_INVOCATION_ARN_CHANNEL_GET                            = dependency.channel_get.outputs.invoke_arn
      LAMBDA_INVOCATION_ARN_CHANNEL_PATCH                          = dependency.channel_patch.outputs.invoke_arn
      LAMBDA_INVOCATION_ARN_CHANNEL_POST                           = dependency.channel_post.outputs.invoke_arn
      LAMBDA_INVOCATION_ARN_FILTER-DICTIONARY_DELETE               = dependency.filter-dictionary_delete.outputs.invoke_arn
      LAMBDA_INVOCATION_ARN_FILTER-DICTIONARY_GET                  = dependency.filter-dictionary_get.outputs.invoke_arn
      LAMBDA_INVOCATION_ARN_FILTER-DICTIONARY_PATCH                = dependency.filter-dictionary_patch.outputs.invoke_arn
      LAMBDA_INVOCATION_ARN_FILTER-DICTIONARY_POST                 = dependency.filter-dictionary_post.outputs.invoke_arn
      LAMBDA_INVOCATION_ARN_NOTIFICATION_CONFIRM_SUBSCRIPTION_POST = dependency.notification_confirm_subscription_post.outputs.invoke_arn
      LAMBDA_INVOCATION_ARN_NOTIFICATION_SUBSCRIBE_POST            = dependency.notification_subscribe_post.outputs.invoke_arn
      LAMBDA_INVOCATION_ARN_NOTIFICATION_TEST_POST                 = dependency.notification_test_post.outputs.invoke_arn
      LAMBDA_INVOCATION_ARN_NOTIFICATION_UNSUBSCRIBE_POST          = dependency.notification_unsubscribe_post.outputs.invoke_arn
      LAMBDA_INVOCATION_ARN_PRODUCT_GET                            = dependency.product_get.outputs.invoke_arn
      LAMBDA_INVOCATION_ARN_PRODUCT_LIST_GET                       = dependency.product_list_get.outputs.invoke_arn
      LAMBDA_INVOCATION_ARN_PRODUCT_QUALITY_GET                    = dependency.product_quality_get.outputs.invoke_arn
      LAMBDA_INVOCATION_ARN_RELEASE_ARTICLE_CANDIDATE_GET          = dependency.release_article_candidate_get.outputs.invoke_arn
      LAMBDA_INVOCATION_ARN_RELEASE_ARTICLE_CANDIDATE_POST         = dependency.release_article_candidate_post.outputs.invoke_arn
      LAMBDA_INVOCATION_ARN_RELEASE_ARTICLE_GET                    = dependency.release_article_get.outputs.invoke_arn
      LAMBDA_INVOCATION_ARN_RELEASE_ARTICLE_POST                   = dependency.release_article_post.outputs.invoke_arn
      LAMBDA_INVOCATION_ARN_RELEASE_ARTICLE_QUALITY_GET            = dependency.release_article_quality_get.outputs.invoke_arn
      LAMBDA_INVOCATION_ARN_SYSTEM_GET                             = dependency.system_get.outputs.invoke_arn
    }
    base_path           = "core"
    bucket_api_spec_key = "api-productlake-core${local.versions.variables["api_artifact_tag"]}.json"
    description         = "open-api specification handling core functionality"
    name                = "api-productlake-core"
    parameter = {
      "API_NAME_CORE" = "api-productlake-core"
      "API_URL_CORE"  = "https://${local.stage.variables["domain_name"]}/core/"
    }
    # enriched attributes

    # composed attributes
    artifact_bucket_name = "${local.environment.variables["account-id-shs"]}-${local.apigateway_commons.variables["bucket_name"]}"
    domain_name          = dependency.certificate.outputs.domain_name
  }
)

include {
  path = find_in_parent_folders()
}
