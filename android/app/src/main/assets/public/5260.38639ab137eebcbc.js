"use strict";(self.webpackChunkapp=self.webpackChunkapp||[]).push([[5260],{5260:(N,v,s)=>{s.r(v),s.d(v,{AuthModule:()=>H});var m=s(6814),l=s(8854),c=s(8709),C=s(8180),y=s(9397),x=s(6208),t=s(5879),a=s(6223),F=s(186),u=s(9810);function w(e,i){if(1&e&&(t.TgZ(0,"small",3),t._uU(1),t.qZA()),2&e){const r=i.$implicit;t.xp6(1),t.hij(" ",r.message," ")}}function B(e,i){if(1&e&&(t.ynx(0),t.YNc(1,w,2,1,"small",2),t.ALo(2,"async"),t.BQk()),2&e){const r=t.oxw();t.xp6(1),t.Q6J("ngForOf",t.lcZ(2,1,r.formControlErrors))}}let U=(()=>{var e;class i extends l.am{}return(e=i).\u0275fac=function(){let r;return function(o){return(r||(r=t.n5z(e)))(o||e)}}(),e.\u0275cmp=t.Xpm({type:e,selectors:[["wrangler-mobile-input"]],features:[t.qOj],decls:2,vars:6,consts:[["labelPlacement","stacked",3,"label","formControl","readonly","placeholder","type"],[4,"ngIf"],["class","helper-text error-text error-color sc-ion-input-md",4,"ngFor","ngForOf"],[1,"helper-text","error-text","error-color","sc-ion-input-md"]],template:function(n,o){1&n&&(t._UZ(0,"ion-input",0),t.YNc(1,B,3,3,"ng-container",1)),2&n&&(t.Q6J("label",o.label)("formControl",o.inputFormControl)("readonly",o.readonly)("placeholder",o.placeholder)("type",o.type),t.xp6(1),t.Q6J("ngIf",null==o.inputFormControl?null:o.inputFormControl.touched))},dependencies:[m.sg,m.O5,u.pK,u.j9,a.JJ,a.oH,m.Ov],styles:[".error-color[_ngcontent-%COMP%]{color:#ff4961}"]}),i})(),T=(()=>{var e;class i{constructor(){this.buttonText="",this.expand="default",this.disabled=!1,this.type="button",this.color="primary",this.clicked=new t.vpe}emitClicked(n){this.clicked.emit(n)}}return(e=i).\u0275fac=function(n){return new(n||e)},e.\u0275cmp=t.Xpm({type:e,selectors:[["wrangler-mobile-button"]],inputs:{buttonText:"buttonText",expand:"expand",disabled:"disabled",type:"type",color:"color"},outputs:{clicked:"clicked"},decls:2,vars:5,consts:[[3,"expand","disabled","type","color","click"]],template:function(n,o){1&n&&(t.TgZ(0,"ion-button",0),t.NdJ("click",function(d){return o.emitClicked(d)}),t._uU(1),t.qZA()),2&n&&(t.Q6J("expand",o.expand)("disabled",o.disabled)("type",o.type)("color",o.color),t.xp6(1),t.Oqu(o.buttonText))},dependencies:[u.YG]}),i})();function Y(e,i){if(1&e&&(t.ynx(0),t._UZ(1,"wrangler-mobile-input",11),t.ALo(2,"formGet"),t.BQk()),2&e){const r=t.oxw();t.xp6(1),t.Q6J("inputFormControl",t.xi3(2,1,r.form,"displayname"))}}function M(e,i){if(1&e&&t._UZ(0,"wrangler-mobile-button",12),2&e){const r=t.oxw();t.Q6J("buttonText",r.secondaryButtonText)("routerLink",r.secondaryButtonRouterLink)}}function Q(e,i){if(1&e&&t._UZ(0,"app-input",13),2&e){const r=t.oxw();t.Q6J("inputFormControl",r.homeserverUrlFormControl)("readonly",!0)}}let A=(()=>{var e;class i extends l.Bt{constructor(n,o,p,d,f,Z){super(n,o,p,d,f,Z),this.authFormUtil=n,this.formBuilder=o,this.route=p,this.router=d,this.store=f,this.userValidators=Z}ngOnInit(){super.ngOnInit(),this.initHomeserverUrlFormControl()}initHomeserverUrlFormControl(){this.homeserverUrlFormControl=this.formBuilder.control(this.store.selectSnapshot(x.a.url))}submit(){this.form.valid&&this.authFormUtil.getSubmitObservable(this.form,this.isSignUp.value).pipe((0,C.q)(1),(0,y.b)(()=>{this.isSignUp.value||this.router.navigate(["/groups"])})).subscribe()}}return(e=i).\u0275fac=function(n){return new(n||e)(t.Y36(l.eJ),t.Y36(a.qu),t.Y36(c.gz),t.Y36(c.F0),t.Y36(F.yh),t.Y36(l.aN))},e.\u0275cmp=t.Xpm({type:e,selectors:[["app-mobile-auth-form"]],features:[t._Bn([l.aN]),t.qOj],decls:17,vars:16,consts:[[1,"ion-padding"],[1,"d-flex","ion-align-items-center","ion-justify-content-center","w-100","h-100",3,"formGroup","ngSubmit"],[1,"d-flex","flex-column","w-100"],["label","URL",3,"inputFormControl"],[4,"ngIf"],["label","Username",3,"inputFormControl"],["label","Password",1,"mb-2",3,"inputFormControl"],[1,"d-flex","flex-column"],["expand","block","type","submit",3,"buttonText"],["expand","block","type","button","color","secondary",3,"buttonText","routerLink",4,"appFeature"],["additionalFields",""],["label","Displayname",3,"inputFormControl"],["expand","block","type","button","color","secondary",3,"buttonText","routerLink"],["label","Homeserver URL",3,"inputFormControl","readonly"]],template:function(n,o){1&n&&(t.TgZ(0,"ion-content",0)(1,"form",1),t.NdJ("ngSubmit",function(){return o.submit()}),t.TgZ(2,"div",2)(3,"h2"),t._uU(4),t.qZA(),t._UZ(5,"wrangler-mobile-input",3),t.YNc(6,Y,3,4,"ng-container",4),t.ALo(7,"async"),t._UZ(8,"wrangler-mobile-input",5),t.ALo(9,"formGet"),t._UZ(10,"wrangler-mobile-input",6),t.ALo(11,"formGet"),t.TgZ(12,"div",7),t._UZ(13,"wrangler-mobile-button",8),t.YNc(14,M,1,2,"wrangler-mobile-button",9),t.qZA()()()(),t.YNc(15,Q,1,2,"ng-template",null,10,t.W1O)),2&n&&(t.xp6(1),t.Q6J("formGroup",o.form),t.xp6(3),t.Oqu(o.headerText),t.xp6(1),t.Q6J("inputFormControl",o.homeserverUrlFormControl),t.xp6(1),t.Q6J("ngIf",t.lcZ(7,8,o.isSignUp)),t.xp6(2),t.Q6J("inputFormControl",t.xi3(9,10,o.form,"username")),t.xp6(2),t.Q6J("inputFormControl",t.xi3(11,13,o.form,"password")),t.xp6(3),t.Q6J("buttonText",o.primaryButtonText),t.xp6(1),t.Q6J("appFeature","enableLocalSignUp"))},dependencies:[c.rH,m.O5,l.EY,l.am,u.W2,u.YI,a._Y,a.JL,a.sg,U,T,m.Ov,l.wn]}),i})();var I=s(6306),L=s(2096),S=s(1292);let O=(()=>{var e;class i{constructor(n,o,p,d,f){this.formBuilder=n,this.store=o,this.featureConfigService=p,this.router=d,this.snackbarService=f,this.form=new a.cw({})}ngOnInit(){this.initForm()}initForm(){this.form.addControl("url",this.formBuilder.control(this.store.selectSnapshot(x.a.url),{validators:[a.kI.required]}))}submit(){this.form.valid&&(this.store.dispatch(new S.y(this.form.value.url)),this.featureConfigService.getFeatureConfig().pipe((0,C.q)(1),(0,y.b)(()=>{this.snackbarService.success("Successfully connected to server"),this.router.navigate(["/auth","login"])}),(0,I.K)(n=>(this.snackbarService.error("Couldn't connect to server"),this.store.dispatch(new S.y("")),(0,L.of)(n)))).subscribe())}}return(e=i).\u0275fac=function(n){return new(n||e)(t.Y36(a.qu),t.Y36(F.yh),t.Y36(l.UN),t.Y36(c.F0),t.Y36(l.o))},e.\u0275cmp=t.Xpm({type:e,selectors:[["app-set-homeserver"]],decls:10,vars:5,consts:[[1,"ion-padding"],[1,"d-flex","ion-align-items-center","ion-justify-content-center","w-100","h-100"],[1,"w-100",3,"formGroup","ngSubmit"],[1,"d-flex","flex-column"],["label","Homeserver Url",1,"mb-2",3,"inputFormControl"],[1,"w-100","d-flex","flex-column"],["expand","block","buttonText","Next","type","submit"]],template:function(n,o){1&n&&(t.TgZ(0,"ion-content",0)(1,"div",1)(2,"form",2),t.NdJ("ngSubmit",function(){return o.submit()}),t.TgZ(3,"h2"),t._uU(4,"Set Homeserver URL"),t.qZA(),t.TgZ(5,"div",3),t._UZ(6,"wrangler-mobile-input",4),t.ALo(7,"formGet"),t.qZA(),t.TgZ(8,"div",5),t._UZ(9,"wrangler-mobile-button",6),t.qZA()()()()),2&n&&(t.xp6(2),t.Q6J("formGroup",o.form),t.xp6(4),t.Q6J("inputFormControl",t.xi3(7,2,o.form,"url")))},dependencies:[u.W2,a._Y,a.JL,a.sg,U,T,l.wn]}),i})();var J=s(1111);const h=[{path:"homeserver",component:O},...l.jb],g=h.find(e=>"login"===e.path);g&&(g.component=A,g.canActivate=[J.E]);const b=h.find(e=>"sign-up"===e.path);b&&(b.component=A,b.canActivate=[J.E]);let _=(()=>{var e;class i{}return(e=i).\u0275fac=function(n){return new(n||e)},e.\u0275mod=t.oAB({type:e}),e.\u0275inj=t.cJS({imports:[c.Bz.forChild(h),c.Bz]}),i})(),k=(()=>{var e;class i{}return(e=i).\u0275fac=function(n){return new(n||e)},e.\u0275mod=t.oAB({type:e}),e.\u0275inj=t.cJS({imports:[m.ez,u.Pc,a.UX]}),i})(),H=(()=>{var e;class i{}return(e=i).\u0275fac=function(n){return new(n||e)},e.\u0275mod=t.oAB({type:e}),e.\u0275inj=t.cJS({providers:[l.eJ],imports:[_,l.hJ,m.ez,l.ny,l.or,l.gP,u.Pc,l.Dt,a.UX,k]}),i})()}}]);