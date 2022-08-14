variable "name" {
  type        = string
  description = "The name to use when creating resources."

  validation {
    condition     = length(var.name) != 0
    error_message = "The \"name\" variable is required and expected to be a string."
  }
}
