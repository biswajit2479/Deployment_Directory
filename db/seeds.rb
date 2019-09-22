Deployment.where(name: "passport").first_or_create
Deployment.where(name: "portal").first_or_create
Deployment.where(name: "api_gw").first_or_create
Deployment.where(name: "transporter").first_or_create
Deployment.where(name: "octopus").first_or_create
Deployment.where(name: "api_adapter").first_or_create
Cluster.where(name: "staging").first_or_create
Cluster.where(name: "demo").first_or_create
EventType.where(event_type: "Tradeshow").first_or_create
EventType.where(event_type: "EBC").first_or_create
EventType.where(event_type: "JFS").first_or_create
EventType.where(event_type: "Staff Scheduling").first_or_create
CsmInfo.where(email: "ethan.nutter@jifflenow.com",name: "Ethan Nutter").first_or_create
CsmInfo.where(email: "mike.joy@jifflenow.com",name: "Mike Joy").first_or_create
CsmInfo.where(email: "lou.mendoza",name: "Lou Mendoza").first_or_create
Role.where(name: "Super Admin").first_or_create
Role.where(name: "L1").first_or_create
Role.where(name: "L2").first_or_create
Role.where(name: "Normal User").first_or_create