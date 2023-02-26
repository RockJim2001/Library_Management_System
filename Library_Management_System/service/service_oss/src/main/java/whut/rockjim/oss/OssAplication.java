package whut.rockjim.oss;/**
 * Created by IntelliJ IDEA.
 *
 * @Author : RockJim
 * @create 2022/12/6 21:51
 */

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.context.annotation.ComponentScan;

/**
 * Created by IntelliJ IDEA.
 * @Author : RockJim
 * @create 2022/12/6 21:51
 */
@SpringBootApplication(exclude = DataSourceAutoConfiguration.class)// 不自动加载数据库
@EnableDiscoveryClient
@ComponentScan("whut.rockjim")
public class OssAplication {
    public static void main(String[] args) {
        SpringApplication.run(OssAplication.class,args);
    }
}
