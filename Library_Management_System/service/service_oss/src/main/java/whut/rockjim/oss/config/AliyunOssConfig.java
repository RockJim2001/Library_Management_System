package whut.rockjim.oss.config;

import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;


/**
 * Created by IntelliJ IDEA.
 * @Author : RockJim
 * @create 2022/11/23 11:24
 */
@Slf4j
//@Data
@Component
//@ConfigurationProperties(prefix = "aliyun.oss")
public class AliyunOssConfig implements InitializingBean {
        /**
         * 访问控制id
         */
        @Value("${aliyun.oss.accessKeyId}")
        private String accessKeyId;
        /**
         * 访问控制secret
         */
        @Value("${aliyun.oss.accessKeySecret}")
        private String accessKeySecret;
        /**
         * bucketName
         */
        @Value("${aliyun.oss.bucketName}")
        private String bucketName;
        /**
         * 地域结点
         */
        @Value("${aliyun.oss.endpoint}")
        private String endpoint;


public static String END_POINT;
public static String BUCKET_NAME;
public static String ACCESS_KEY_SECERET;
public static String ACCESS_KEY_ID;

        @Override
        public void afterPropertiesSet() throws Exception {
                END_POINT=endpoint;
                BUCKET_NAME=bucketName;
                ACCESS_KEY_ID=accessKeyId;
                ACCESS_KEY_SECERET=accessKeySecret;
        }
}
