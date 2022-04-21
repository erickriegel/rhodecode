project = "forge/rhodecode/rhodecode-app"

labels = { "domaine" = "forge" }

runner {
    enabled = true
    data_source "git" {
        url  = "https://github.com/eriegel/rhodecode.git"
        ref  = "main"
		path = "/rhodecode-app"
		ignore_changes_outside_path = true
    }
}

app "rhodecode-app" {

    build {
        use "docker-pull" {
            image = var.image
            tag   = var.tag
	        disable_entrypoint = true
        }
    }
  
    deploy{
        use "nomad-jobspec" {
            jobspec = templatefile("${path.app}/rhodecode-app.nomad.tpl", {
            image   = var.image
            tag     = var.tag
            datacenter = var.datacenter
            })
        }
    }
}

variable "datacenter" {
    type    = string
    default = "henix_docker_platform_dev"
}

variable "image" {
    type    = string
    default = "prosanteconnect/rhodecode-app"
}

variable "tag" {
    type    = string
    default = "4.26.0"
}
