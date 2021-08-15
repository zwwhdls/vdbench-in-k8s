# vdbench-in-k8s

Vdbench version is 50406.

## Use vdbench in job 

example:

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: vdbench
data:
  vdbench.vdb: |
    fsd=fsd1,anchor=/data,depth=1,width=1,files=300,size=640k
    fwd=default,xfersize=4k,fileio=random,fileselect=random,threads=4
    fwd=fwd1,fsd=fsd1,rdpct=20
    rd=rd1,fwd=fwd*,fwdrate=max,format=yes,elapsed=300,interval=1
---
apiVersion: batch/v1
kind: Job
metadata:
  name: vdbench
spec:
  template:
    spec:
      containers:
        - name: vdbench
          image: zwwhdlsdocker/vdbench:latest
          imagePullPolicy: Always
          volumeMounts:
            - mountPath: /data
              name: vdbench-pvc
            - mountPath: /vdbench/config
              name: vdbench-cfg
          command: ["sh", "-c", "./vdbench -f /vdbench/config/vdbench.vdb"]
      restartPolicy: Never
      volumes:
        - name: vdbench-pvc
          persistentVolumeClaim:
            claimName: juicefs-data-ce
        - name: vdbench-cfg
          configMap:
            name: vdbench
            items:
              - key: "vdbench.vdb"
                path: "vdbench.vdb"
```

Use ConfigMap to mount parameter as a volume. 
