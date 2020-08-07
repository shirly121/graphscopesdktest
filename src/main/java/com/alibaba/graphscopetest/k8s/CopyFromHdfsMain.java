package com.alibaba.graphscopetest.k8s;

import java.io.FileInputStream;
import java.util.Properties;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FileStatus;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.LocalFileSystem;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.hdfs.DistributedFileSystem;

public class CopyFromHdfsMain {
    public static void main(String[] args) throws Exception {
        Properties properties = new Properties();
        properties.load(new FileInputStream(args[0]));

        Configuration conf = new Configuration();
        conf.set("fs.defaultFS", properties.getProperty("hdfs.url"));
        conf.set("fs.hdfs.impl", DistributedFileSystem.class.getName());
        conf.set("fs.file.impl", LocalFileSystem.class.getName());
        FileSystem fs = FileSystem.get(conf);
        FileStatus[] status = fs.listStatus(new Path(args[1]));

        for (int i = 0; i < status.length; ++i) {
            System.out.println(status[i].getPath());
            fs.copyToLocalFile(false, status[i].getPath(), new Path(properties.getProperty("dst.path")));
        }

        while(true) {
            Thread.sleep(10000);
        }
    }
}
