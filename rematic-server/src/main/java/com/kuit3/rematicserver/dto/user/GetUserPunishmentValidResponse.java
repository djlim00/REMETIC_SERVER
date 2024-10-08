package com.kuit3.rematicserver.dto.user;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter @Setter
@NoArgsConstructor
@AllArgsConstructor
public class GetUserPunishmentValidResponse {

    private Long userId;
    private Boolean isRestricted;
}
