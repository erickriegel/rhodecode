project = "forge/rhodecode/rhodecode-syncldap"

labels = { "domaine" = "forge" }

runner {
    enabled = true
    data_source "git" {
        url  = "https://github.com/erickriegel/rhodecode.git"
        ref  = "main"
	path = "rhodecode-syncldap/"
	ignore_changes_outside_path = true
    }
}

app "rhodecode-syncldap" {

    build {
        use "docker-pull" {
            image = var.image
            tag   = var.tag
			      disable_entrypoint = true
        }
    }
  
    deploy{
        use "nomad-jobspec" {
            jobspec = templatefile("${path.app}/rhodecode-syncldap.nomad.tpl", {
              datacenter = var.datacenter
              image = var.image
              tag   = var.tag
            })
        }
    }
}

variable "datacenter" {
    type    = string
    default = "henix_docker_platform_integ"
}

variable "image" {
    type    = string
    default = "ans/syncldap"
}

variable "tag" {
    type    = string
    default = "1.0"
}
