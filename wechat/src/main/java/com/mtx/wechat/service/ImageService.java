package com.mtx.wechat.service;

import com.mtx.common.base.BaseService;
import com.mtx.common.utils.StringUtils;
import com.mtx.wechat.entity.WechatMedia;
import com.mtx.wechat.entity.admin.Image;
import com.mtx.wechat.mapper.ImageMapper;
import com.mtx.wechat.utils.AdvancedUtil;
import com.mtx.wechat.utils.WechatBindingUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by shanny on 12/22/2014.
 */
@Service
@Transactional
public class ImageService extends BaseService<ImageMapper,Image> {

    @Autowired
    public void setMapper(ImageMapper mapper) {
        super.setMapper(mapper);
    }

    /**
     * 上传图片
     * @param image
     */
    public void uploadImage(Image image,String uploadToServer){
        //需要上传到服务器
        if(StringUtils.isNotBlank(uploadToServer)){
            // 调用接口获取access_token
            String at = WechatBindingUtil.getAccessToken();
            String imagename = image.getImgname();
            WechatMedia wechatMedia = AdvancedUtil.uploadMedia(at,"image", imagename);
            if(null != wechatMedia && StringUtils.isNotBlank(wechatMedia.getMedia_id())){
                image.setMediaid(wechatMedia.getMedia_id());
            }
        }

        this.insert(image);
    }

    /**
     * 查询有mediaid的图片集合
     * @param image
     * @return
     */
    public List<Image> queryImageListHaveMediaId(Image image){
        return this.mapper.selectImageListHaveMediaId(image);
    }
}
