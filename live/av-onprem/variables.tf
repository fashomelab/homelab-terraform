# labsterraform/environments/fashomelab/variables.tf

variable "common_tags" {
  description = "A list of common tags to apply to all VMs in this environment."
  type        = list(string)
  default     = []
}