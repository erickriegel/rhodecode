project = "forge/rhodecode/rhodecode-app"

labels = { "domaine" = "forge" }

runner {
    enabled = true
    data_source "git" {
        url  = "https://github.com/erickriegel/rhodecode.git"
        ref  = "main"
	path = "rhodecode-app/"
	ignore_changes_outside_path = true
    }
}

app "rhodecode-app" {

    build {
        use "docker-pull" {
            image = "ans/rhodecode-app"
            tag   = "4.26.0"
	    disable_entrypoint = true
        }
    }
  
    deploy{
        use "nomad-jobspec" {
            jobspec = templatefile("${path.app}/rhodecode-community.nomad.tpl", {
            datacenter = var.datacenter
            })
        }
    }
}

variable "datacenter" {
    type    = string
    default = "henix_docker_platform_integ"
}

variable "cpu" {
    type    = string
    default = "1024"
}

variable "memory" {
    type    = string
    default = "7168"
}
