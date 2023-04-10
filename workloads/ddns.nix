{
   virtualisation.oci-containers.containers = {
     ddns = {
       image = "oznu/cloudflare-ddns:latest";
       environmentFiles = ["/home/bonky/workspace/cloudflare-ddns/.env"];
     };
   };
 }

