package mihailegorin.app.springbootwebapp.data;

import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class GetServerStatusResponse {

    private String serverIp;
    private String serverTime;
    private String message;

}
