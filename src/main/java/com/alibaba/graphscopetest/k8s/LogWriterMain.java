package com.alibaba.graphscopetest.k8s;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class LogWriterMain {
    private static final Logger logger = LoggerFactory.getLogger(LogWriterMain.class);

    public static void main(String[] args) throws Exception {
        while (true) {
            logger.info("test log directory");
            Thread.sleep(100000);
        }
    }
}
