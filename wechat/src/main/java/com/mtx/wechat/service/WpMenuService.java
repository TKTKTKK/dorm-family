package com.mtx.wechat.service;

import com.mtx.wechat.menu.*;
import com.mtx.common.base.BaseService;
import com.mtx.wechat.entity.wpMenu.WpMenu;
import com.mtx.wechat.mapper.WpMenuMapper;
import com.mtx.wechat.utils.WechatBindingUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by admin on 16-1-14.
 */
@Service
@Transactional
public class WpMenuService extends BaseService<WpMenuMapper,WpMenu> {

    @Autowired
    public void setMapper(WpMenuMapper mapper){
        super.setMapper(mapper);
    }

    /**
     * 所有菜单名
     * @param bindid
     */
    public List<WpMenu> queryWpMenuNames(String bindid){
        WpMenu wpMenu = new WpMenu();
        wpMenu.setBindid(bindid);
        List<WpMenu> wpMenuList = mapper.selectWpMenuName(wpMenu);
        return wpMenuList;
    }
    /**
     * 所有菜单
     * @param bindid
     */
    public List<WpMenu> queryWpMenu(String bindid,String name){
        WpMenu wpMenu = new WpMenu();
        wpMenu.setBindid(bindid);
        wpMenu.setMenusname(name);
        List<WpMenu> wpMenuList = mapper.selectWpMenu(wpMenu);
        if(wpMenuList!=null&&wpMenuList.size()>0){
            for(WpMenu wpMenuMaster:wpMenuList){
                List<WpMenu> wpMenuChildList = queryWpMenuChild(bindid,wpMenuMaster.getUuid());
                if(wpMenuChildList != null && wpMenuChildList.size() > 0){
                    wpMenuMaster.setWpChildMenuList(wpMenuChildList);
                }
            }
        }
        return wpMenuList;
    }

    /**
     * 子菜单
     * @param bindid
     * @param parentid
     */
    public List<WpMenu> queryWpMenuChild(String bindid,String parentid){
        WpMenu wpMenu = new WpMenu();
        wpMenu.setBindid(bindid);
        wpMenu.setParentid(parentid);
        List<WpMenu> wpMenuList = mapper.selectWpMenu(wpMenu);
        return wpMenuList;
    }

    /**
     * 主菜单
     * @param wpMenu
     */
    public WpMenu queryWpMenuMaster(WpMenu wpMenu){
        wpMenu = mapper.selectWpMenuMaster(wpMenu);
        return wpMenu;
    }

    /**
     * 根据菜单组名称查询菜单
     * @param bindid
     * @param name
     */
    public List<WpMenu> queryWpMenuByName(String bindid,String name){
        WpMenu wpMenu = new WpMenu();
        wpMenu.setBindid(bindid);
        wpMenu.setMenusname(name);
        List<WpMenu> wpMenus = mapper.selectWpMenuByName(wpMenu);
        return wpMenus;
    }


    /**
     * 创建微信菜单
     * @param bindid
     * @return
     */
    public void createWechatMenu(String bindid,String name){
        List<WpMenu> wpMenus = queryWpMenu(bindid,name);
        List<Button> mainButtonList = new ArrayList<Button>();

        for(WpMenu mainMenu : wpMenus){
            List<WpMenu> subMenus = mainMenu.getWpChildMenuList();
            if(subMenus != null && subMenus.size() > 0){
                ComplexButton mainButton = new ComplexButton();
                mainButton.setName(mainMenu.getName());
                List<Button> subButtonList = new ArrayList<Button>();
                for(WpMenu subMenu : subMenus){
                    Button button = buildButton(subMenu);
                    subButtonList.add(button);
                }
                mainButton.setSub_button(subButtonList.toArray(new Button[subButtonList.size()]));
                mainButtonList.add(mainButton);
            }else{
                Button button = buildButton(mainMenu);
                mainButtonList.add(button);
            }
        }

        Button[] menuArray = mainButtonList.toArray(new Button[mainButtonList.size()]);

        Menu menu = new Menu();
        menu.setButton(menuArray);

        //个性化菜单
        Matchrule matchrule = new Matchrule();
        if(wpMenus!=null && wpMenus.size()>0 && "S".equals(wpMenus.get(0).getMenustype())){
            matchrule.setGroup_id(wpMenus.get(0).getGroupid());
            menu.setMatchrule(matchrule);
            WechatBindingUtil.createConditionalMenu(menu);
            return;
        }
        //默认菜单
        WechatBindingUtil.createMenu(menu);
        return;
    }

    private Button buildButton(WpMenu wpMenu){
        if("VIEW".equals(wpMenu.getType())){
            ViewButton viewButton = new ViewButton();
            viewButton.setName(wpMenu.getName());
            viewButton.setType("view");
            viewButton.setUrl(wpMenu.getLink());
            return viewButton;
        }
        return null;
    }


    /**
     * 删除微信菜单
     * @return
     */
    public void deleteWechatMenu(){
        WechatBindingUtil.deleteMenu();
    }
}
