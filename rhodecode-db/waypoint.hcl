project = "forge/rhodecode/rhodecode-db"

labels = { "domaine" = "forge" }

runner {
    enabled = true
    data_source "git" {
        url  = "https://github.com/erickriegel/rhodecode.git"
        ref  = "main"
	path = "rhodecode-db/"
	ignore_changes_outside_path = true
    }
}

app "rhodecode-db" {

    build {
        use "docker-pull" {
            image = "ans/rhodecode-database"
            tag   = "13.5"
	    disable_entrypoint = true
        }
    }
  
    deploy{
        use "nomad-jobspec" {
            jobspec = templatefile("${path.app}/rhodecode-postgres.nomad.tpl", {
            datacenter = var.datacenter
            })
        }
    }
}

variable "datacenter" {
    type    = string
    default = "henix_docker_platform_integ"
}
