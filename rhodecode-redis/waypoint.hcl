project = "forge/rhodecode/rhodecode-redis"

labels = { "domaine" = "forge" }

runner {
    enabled = true
    data_source "git" {
        url  = "https://github.com/erickriegel/rhodecode.git"
        ref  = "main"
	path = "rhodecode-redis/"
	ignore_changes_outside_path = true
    }
}

app "rhodecode-redis" {

    build {
        use "docker-pull" {
            image = "ans/rhodecode-redis"
            tag   = "6.2.6"
	    disable_entrypoint = true
        }
    }
  
    deploy{
        use "nomad-jobspec" {
            jobspec = templatefile("${path.app}/rhodecode-redis.nomad.tpl", {
            datacenter = var.datacenter
            })
        }
    }
}

variable "datacenter" {
    type    = string
    default = "henix_docker_platform_integ"
}
