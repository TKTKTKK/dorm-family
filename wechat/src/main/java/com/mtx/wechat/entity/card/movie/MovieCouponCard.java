package com.mtx.wechat.entity.card.movie;

import com.mtx.wechat.entity.card.base.Card;

/**
 * Created by wensheng on 12/17/2014.
 */
public class MovieCouponCard extends Card {

    private MovieCoupon movie_ticket;

    public MovieCoupon getMovie_ticket() {
        return movie_ticket;
    }

    public void setMovie_ticket(MovieCoupon movie_ticket) {
        this.movie_ticket = movie_ticket;
    }
}
