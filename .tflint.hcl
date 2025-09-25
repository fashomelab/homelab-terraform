# .tflint.hcl
   plugin "terraform" {
     enabled = true
     preset  = "recommended"
   }

   plugin "azurerm" {
     enabled = true
     version = "0.27.0"
     source  = "github.com/terraform-linters/tflint-ruleset-azurerm"
   }

   rule "terraform_module_pinned_source" {
     enabled = false # Disable as your repo uses local modules
   }

   rule "terraform_naming_convention" {
     enabled = true
     format  = "snake_case"
   }

   rule "terraform_required_providers" {
     enabled = true
   }

   rule "terraform_required_version" {
     enabled = true
   }