package com.alibaba.graphscopetest.k8s;

import java.io.*;
import java.util.Properties;

public class LocalVolumeMain {
    public static void main(String[] args) throws Exception {
        Properties properties = new Properties();
        properties.load(new FileInputStream(args[0]));
        String volumePath = properties.getProperty("volume.path");
        BufferedWriter writer = new BufferedWriter(new FileWriter(volumePath, true));
        writer.write("add new line");
        writer.newLine();
        writer.close();

        while(true) {
            Thread.sleep(10000);
        }
    }
}
