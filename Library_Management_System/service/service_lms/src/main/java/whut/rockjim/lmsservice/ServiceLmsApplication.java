package whut.rockjim.lmsservice;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.scheduling.annotation.EnableScheduling;

/**
 * Created by IntelliJ IDEA.
 * @Author : RockJim
 * @create 2022/11/27 14:22
 */
@SpringBootApplication
@EnableDiscoveryClient
@ComponentScan("whut.rockjim")
@MapperScan("whut.rockjim.lmsservice.mapper")
@EnableScheduling
public class ServiceLmsApplication {
    public static void main(String[] args) {
        SpringApplication.run(ServiceLmsApplication.class,args);
    }
}
