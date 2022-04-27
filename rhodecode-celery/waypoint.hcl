project = "forge/rhodecode/rhodecode-celery"

labels = { "domaine" = "forge" }

runner {
    enabled = true
    data_source "git" {
        url  = "https://github.com/erickriegel/rhodecode.git"
        ref  = "main"
	path = "rhodecode-celery/"
	ignore_changes_outside_path = true
    }
}

app "rhodecode-celery" {

    build {
        use "docker-pull" {
            image = "ans/rhodecode-app"
            tag   = "4.26.0"
	    disable_entrypoint = true
        }
    }
  
    deploy{
        use "nomad-jobspec" {
            jobspec = templatefile("${path.app}/rhodecode-celery.nomad.tpl", {
            	datacenter = var.datacenter
            })
        }
    }
}

variable "datacenter" {
    type    = string
    default = "henix_docker_platform_integ"
}
