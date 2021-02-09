data "template_file" "mapping_template" {
  template = file("modules/endpoints/mapping_templates/application_json_mapping_template.tpl")
}