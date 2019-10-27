import { Component, OnInit, ViewChild } from '@angular/core';
import { FacebookService, InitParams,LoginResponse } from 'ngx-facebook';

const screenfull = require('screenfull');
const browser = require('jquery.browser');
declare var $: any;
import { environment } from '../../../environments/environment';
import { UserblockService } from '../sidebar/userblock/userblock.service';
import { SettingsService } from '../../core/settings/settings.service';
import { MenuService } from '../../core/menu/menu.service';

@Component({
    selector: 'app-header',
    templateUrl: './header.component.html',
    styleUrls: ['./header.component.scss']
})
export class HeaderComponent implements OnInit {

    navCollapsed = true; // for horizontal layout
    menuItems = []; // for horizontal layout
    userId:any = '';
    usuario:any = '';
    isNavSearchVisible: boolean;
    @ViewChild('fsbutton') fsbutton;  // the fullscreen button
    lk_client_id = '77sc9udgaee7qe';
    lk_redirect_uri = environment.lk_urlRedirect;
    lk_state=1970499;
    lk_scope='r_basicprofile&r_emailaddress';
    lk_url = "https://www.linkedin.com/oauth/v2/authorization?response_type=code&client_id="+this.lk_client_id+"&redirect_uri="+this.lk_redirect_uri+"&state="+this.lk_state+"&scope="+this.lk_scope+"";
    constructor(public menu: MenuService, public userblockService: UserblockService, 
        public settings: SettingsService,private fb: FacebookService) {

        // show only a few items on demo
        this.menuItems = menu.getMenu().slice(0,4); // for horizontal layout
    
        let initParams: InitParams = {
            appId: '291698434931584',
            xfbml: true,
            version: 'v3.1'
          };
       
          fb.init(initParams);
        
    }

    ngOnInit() {
        this.isNavSearchVisible = false;
        if (browser.msie) { // Not supported under IE
            this.fsbutton.nativeElement.style.display = 'none';
        }
        this.usuario = JSON.parse(localStorage.getItem("usuario"));
    }

    toggleUserBlock(event) {
        event.preventDefault();
        this.userblockService.toggleVisibility();
    }

    openNavSearch(event) {
        event.preventDefault();
        event.stopPropagation();
        this.setNavSearchVisible(true);
    }

    setNavSearchVisible(stat: boolean) {
        // console.log(stat);
        this.isNavSearchVisible = stat;
    }

    getNavSearchVisible() {
        return this.isNavSearchVisible;
    }

    toggleOffsidebar() {
        this.settings.layout.offsidebarOpen = !this.settings.layout.offsidebarOpen;
    }

    toggleCollapsedSideabar() {
        this.settings.layout.isCollapsed = !this.settings.layout.isCollapsed;
    }

    isCollapsedText() {
        return this.settings.layout.isCollapsedText;
    }

    toggleFullScreen(event) {

        if (screenfull.enabled) {
            screenfull.toggle();
        }
        // Switch icon indicator
        let el = $(this.fsbutton.nativeElement);
        if (screenfull.isFullscreen) {
            el.children('em').removeClass('fa-expand').addClass('fa-compress');
        }
        else {
            el.children('em').removeClass('fa-compress').addClass('fa-expand');
        }
    }

    loginWithFacebook(): void {
        try {
            let me = this;
            this.fb.login()
            .then((response: LoginResponse) => me.userId = response.authResponse.userID)
            .catch((error: any) => console.error(error)
            );
            
            if(me.userId != '' && me.userId != null){
                this.userblockService.getUserFacebook(me.userId).subscribe(
                    users => this.usuario = users,
                    error => console.log('erro')
                );
                if(this.usuario != ''){
                    localStorage.setItem("usuario",JSON.stringify(this.usuario));
                }
                
            }    
        } catch (error) {
            console.log(error.message);
        }
         
    }

    loginWithLinkedin(){
        this.userblockService.getUserLinkedin().subscribe(
            users => console.log(users),
            error => console.log('erro')
        );
    }

}
