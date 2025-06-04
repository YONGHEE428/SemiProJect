// data.util.S3Config.java
package data.util;

import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.auth.EnvironmentVariableCredentialsProvider; // 이 라인은 사실 필요 없습니다.

public class S3Config {
    // 버킷 이름과 리전은 민감 정보가 아니므로 코드에 두거나 환경 변수로 관리할 수 있습니다.
    private static String S3_BUCKET_NAME = "ssy-img-files"; // 실제 버킷 이름으로 변경
    private static Regions S3_REGION = Regions.AP_NORTHEAST_2; // 서울 리전 (ap-northeast-2)

    private static AmazonS3 s3Client;

    public static AmazonS3 getS3Client() {
        if (s3Client == null) {
            // AWS SDK의 기본 자격 증명 체인이 환경 변수를 자동으로 찾습니다.
            // 따라서 별도로 .withCredentials()를 호출할 필요가 없습니다.
            s3Client = AmazonS3ClientBuilder.standard()
                    .withRegion(S3_REGION)
                    .build();
        }
        return s3Client;
    }

    public static String getS3BucketName() {
        return S3_BUCKET_NAME;
    }

    public static String getS3BaseUrl() {
        return "https://" + S3_BUCKET_NAME + ".s3." + S3_REGION.getName() + ".amazonaws.com/";
    }
}