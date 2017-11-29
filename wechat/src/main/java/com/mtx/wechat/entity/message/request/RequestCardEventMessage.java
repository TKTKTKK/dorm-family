package com.mtx.wechat.entity.message.request;

/**
 * Created by wensheng on 1/16/2015.
 */
public class RequestCardEventMessage extends RequestEventMessage {

    private String FriendUserName;
    private String CardId;
    private Integer IsGiveByFriend;
    private String UserCardCode;
    private Integer OuterId;

    public String getFriendUserName() {
        return FriendUserName;
    }

    public void setFriendUserName(String friendUserName) {
        FriendUserName = friendUserName;
    }

    public String getCardId() {
        return CardId;
    }

    public void setCardId(String cardId) {
        CardId = cardId;
    }

    public Integer getIsGiveByFriend() {
        return IsGiveByFriend;
    }

    public void setIsGiveByFriend(Integer isGiveByFriend) {
        IsGiveByFriend = isGiveByFriend;
    }

    public String getUserCardCode() {
        return UserCardCode;
    }

    public void setUserCardCode(String userCardCode) {
        UserCardCode = userCardCode;
    }

    public Integer getOuterId() {
        return OuterId;
    }

    public void setOuterId(Integer outerId) {
        OuterId = outerId;
    }
}
