{
    "Job": {
        "Datacenters": [
            "            "
        ],
        "ID": "jenkins-53b96728cc4",
        "Name": "jenkins-53b96728cc4",
        "Priority": 50,
        "Region": "global",
        "TaskGroups": [
            {
                "Count": 1,
                "Name": "jenkins-slave-taskgroup",
                "RestartPolicy": {
                    "Attempts": 0,
                    "Delay": 1000000000,
                    "Interval": 10000000000,
                    "Mode": "fail"
                },
                "Tasks": [
                    {
                        "Artifacts": [
                            {
                                "GetterSource": "http://jenkins-master.service.consul:8080/jnlpJars/slave.jar",
                                "RelativeDest": ""
                            }
                        ],
                        "Config": {
                            "args": [
                                "-jar",
                                "/local/slave.jar",
                                "-jnlpUrl",
                                "http://jenkins-master.service.consul:8080/computer/jenkins-53b96728cc4/slave-agent.jnlp"
                            ],
                            "command": "java",
                            "image": "registry.service.consul:5000/jenkins/slave-micro-app",
                            "network_mode": "bridge",
                            "privileged": false
                        },
                        "Driver": "docker",
                        "LogConfig": {
                            "MaxFileSizeMB": 10,
                            "MaxFiles": 1
                        },
                        "Name": "jenkins-slave",
                        "Resources": {
                            "CPU": 100,
                            "DiskMB": 100,
                            "MemoryMB": 128
                        }
                    }
                ]
            }
        ],
        "Type": "batch"
    }
}
