{ config, pkgs, ... }:

{
  systemd.services.create-immich-net = with config.virtualisation.oci-containers; {
    description = "Create the network bridge for Immich.";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    
    serviceConfig.Type = "oneshot";
    script = let podmancli = "${pkgs.podman}/bin/podman";
             in ''
              # immich-net network
              check=$(${podmancli} network ls | grep "immich-net" || true)
              if [ -z "$check" ]; then
                ${podmancli} network create immich-net
              else
                echo "immich-net already exists in podman"
              fi
            '';
  };
  
  # Immich
  virtualisation.oci-containers.containers = {
    immich = {
      autoStart = true;
      image = "ghcr.io/imagegenius/immich:latest";
      volumes = [
        "~/.config/immich:/config"
        "~/Pictures/:/photos"
        "/etc/localtime:/etc/localtime:ro"
      ];
      ports = [ "2283:8080" ];
      environment = {
        PUID = "1000";
        PGID = "1000";
        TZ = "America/Chicago"; # Change this to your timezone
        DB_HOSTNAME = "postgres14";
        DB_USERNAME = "postgres";
        DB_PASSWORD = "postgres";
        DB_DATABASE_NAME = "immich";
        REDIS_HOSTNAME = "redis";
      };
      extraOptions = [ "--network=immich-net" "--gpus=all" ];
    };

    redis = {
      autoStart = true;
      image = "redis";
      ports = [ "6379:6379" ];
      extraOptions = [ "--network=immich-net" ];
    };

    postgres14 = {
      autoStart = true;
      image = "tensorchord/pgvecto-rs:pg14-v0.2.0";
      ports = [ "5432:5432" ];
      volumes = [
        "pgdata:/var/lib/postgresql/data"
      ];
      environment = {
        POSTGRES_USER = "postgres";
        POSTGRES_PASSWORD = "postgres";
        POSTGRES_DB = "immich";
      };
      extraOptions = [ "--network=immich-net" ];
    };
  };

}
