# Testing ansible for zos from a container

This repository can be used for a fast start with ansible for z/OS

Currently the following samples are available on the image for trial:
```
- ping          - To test connection with the LPAR 
- submit-job    - To interact submitting a job and taking some vars from this results
- sendf-command - To issue MVS Commands
```

To use ansible with zOS, Python and Z Open Automation Utilities need to be installed on the LPAR

## Getting Started

You can build the container from this repo or taking from docker hub `docker run -it billpereira/demo_ansible:latest`

### Ping

```
ansible-playbook ping.yml -i yourhost.yml

PLAY [zsystem] *******************************************************************************************************************************************************************

TASK [Pinging host - yourhost.com] ****************************************************************************************************************************************
ok: [yourhost.com]

PLAY RECAP ***********************************************************************************************************************************************************************
yourhost.com        : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0 
```

### Submit a job

```
ansible-playbook submit-job.yml -i yourhost.yml

PLAY [all] ***********************************************************************************************************************************************************************

TASK [Submit a IEFBR14] **********************************************************************************************************************************************************
changed: [yourhost.com]

TASK [Setting fact `Job Results`] ************************************************************************************************************************************************
ok: [yourhost.com]

TASK [Results] *******************************************************************************************************************************************************************
ok: [yourhost.com] => {
    "msg": "Job JOB03587 completed with CC 0000"
}

PLAY RECAP ***********************************************************************************************************************************************************************
yourhost.com        : ok=3    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

### Send a command

```
ansible-playbook send-command.yml -i yourhost.yml

PLAY [zsystem] *******************************************************************************************************************************************************************

TASK [Detecting system name] *****************************************************************************************************************************************************
changed: [yourhost.com]

TASK [Setting fact `system_name`] ************************************************************************************************************************************************
ok: [yourhost.com]

TASK [Fact `system_name` set with value] *****************************************************************************************************************************************
ok: [yourhost.com] => {
    "msg": "yourhost"
}

TASK [Checking active tasks for yourhost] *****************************************************************************************************************************************
changed: [yourhost.com]

TASK [Fact `system_name` set with value] *****************************************************************************************************************************************
ok: [yourhost.com] => {
    "msg": [
        "yourhost   2020172  23:13:41.87             ISF031I CONSOLE BILL ACTIVATED",
        "yourhost   2020172  23:13:41.87            -D A,IZU*",
        "yourhost   2020172  23:13:41.87             CNZ4106I 23.13.41 DISPLAY ACTIVITY 112",
        "                                            JOBS     M/S    TS USERS    SYSAS    INITS   ACTIVE/MAX VTAM     OAS",
        "                                           00028    00022    00001      00031    00037    00001/00300       00046",
        "                                            IZUANG1  IZUANG1  STEP1    OWT  SO  A=0040   PER=NO   SMC=000",
        "                                                                                PGN=N/A  DMN=N/A  AFF=NONE",
        "                                                                                CT=000.006S  ET=00288.21",
        "                                                                                WUID=STC03265 USERID=IZUSVR",
        "                                                                                WKL=SYSTEM   SCL=SYSSTC   P=1",
        "                                                                                RGP=N/A      SRVR=NO  QSC=NO",
        "                                                                                ADDR SPACE ASTE=7EE59000",
        "                                            IZUSVR1  IZUSVR1  ZOSMF    IN   SO  A=003D   PER=NO   SMC=000",
        "                                                                                PGN=N/A  DMN=N/A  AFF=NONE",
        "                                                                                CT=00.31.25  ET=00288.20",
        "                                                                                WUID=STC03266 USERID=IZUSVR",
        "                                                                                WKL=STC      SCL=STCLOW   P=1",
        "                                                                                RGP=N/A      SRVR=NO  QSC=NO",
        "                                                                                ADDR SPACE ASTE=7EE45F40"
    ]
}

PLAY RECAP ***********************************************************************************************************************************************************************
yourhost.com        : ok=5    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
```