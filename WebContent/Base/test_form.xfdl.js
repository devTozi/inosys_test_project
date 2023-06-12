(function()
{
    return function()
    {
        if (!this._is_form)
            return;
        
        var obj = null;
        
        this.on_create = function()
        {
            this.set_name("test_form");
            this.set_titletext("New Form");
            this.set_color("transparent");
            this.set_opacity("1");
            if (Form == this.constructor)
            {
                this._setFormPosition(1280,720);
            }
            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("Dataset00", this);
            obj._setContents("<ColumnInfo><Column id=\"codeType\" type=\"STRING\" size=\"10\"/><Column id=\"num\" type=\"INT\" size=\"10\"/><Column id=\"name\" type=\"STRING\" size=\"100\"/><Column id=\"title\" type=\"STRING\" size=\"100\"/><Column id=\"content\" type=\"STRING\" size=\"100\"/><Column id=\"regdate\" type=\"STRING\" size=\"8\"/></ColumnInfo>");
            this.addChild(obj.name, obj);
            
            // UI Components Initialize
            obj = new Static("Static00","314","14","93","66",null,null,null,null,null,null,this);
            obj.set_taborder("0");
            obj.set_text("FreeBoard");
            obj.set_textAlign("center");
            obj.set_color("#040e29");
            this.addChild(obj.name, obj);

            obj = new Grid("Grid00","117","124","483","180",null,null,null,null,null,null,this);
            obj.set_taborder("1");
            obj.set_binddataset("Dataset00");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/></Columns><Rows><Row band=\"head\" size=\"24\"/><Row size=\"24\"/></Rows><Band id=\"head\"><Cell text=\"codeType\"/><Cell col=\"1\" text=\"num\"/><Cell col=\"2\" text=\"name\"/><Cell col=\"3\" text=\"title\"/><Cell col=\"4\" text=\"content\"/><Cell col=\"5\" text=\"regdate\"/></Band><Band id=\"body\"><Cell text=\"bind:codeType\"/><Cell col=\"1\" text=\"bind:num\"/><Cell col=\"2\" text=\"bind:name\"/><Cell col=\"3\" text=\"bind:title\"/><Cell col=\"4\" text=\"bind:content\"/><Cell col=\"5\" text=\"bind:regdate\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Button("Button00","380","320","215","72",null,null,null,null,null,null,this);
            obj.set_taborder("2");
            obj.set_text("저장");
            obj.set_textPadding("저장");
            obj.set_textAlign("center");
            this.addChild(obj.name, obj);

            obj = new Combo("Combo00","150","84","114","32",null,null,null,null,null,null,this);
            obj.set_taborder("3");
            obj.set_text("Combo00");
            this.addChild(obj.name, obj);

            obj = new Edit("Edit00","330","85","126","31",null,null,null,null,null,null,this);
            obj.set_taborder("4");
            this.addChild(obj.name, obj);

            obj = new Calendar("Calendar00","492","90","118","21",null,null,null,null,null,null,this);
            obj.set_taborder("5");
            this.addChild(obj.name, obj);
            // Layout Functions
            //-- Default Layout : this
            obj = new Layout("default","",1280,720,this,function(p){});
            obj.set_mobileorientation("landscape");
            this.addLayout(obj.name, obj);
            
            // BindItem Information

            
            // TriggerItem Information

        };
        
        this.loadPreloadList = function()
        {

        };
        
        // User Script
        this.registerScript("test_form.xfdl", function() {

        	var id = "";
        	var url = "/nexa.ino";
        	var reqDs = "";
        	var respDs = "";
        	var args = "";
        	var callback = "received";

        	// 폼변수
        	this.data = "";
        	this.pagination = "";

        	this.transaction(id, url, reqDs, respDs, args, callback);

        	this.received = function(id, code, message)
        	{
        		if (code == 0) {

        			// console.log("code: "+ code + " message: " + message);
        			const responseString = this.data;
        			//console.log("원본 문자열: "+responseString);

        			// FreeBoardDto 객체 배열 생성
        			const dtoRegex = /FreeBoardDto \[(.*?)\]/g;
        			const dtoMatches = responseString.match(dtoRegex);

        			const dtoArray = dtoMatches.map(dtoMatch => {
        				  const propsRegex = /(\w+)=([^,\]]+)/g;
        				  const propsMatches = Array.from(dtoMatch.matchAll(propsRegex));

        				  const dtoObj = {};
        				  propsMatches.forEach(match => {
        					const propKey = match[1].trim();
        					const propValue = match[2].trim();
        					dtoObj[propKey] = propValue;
        				  });

        				  return dtoObj;
        			});
        			//console.log("파싱 후: "+dtoArray);

        			var dataset = this.Dataset00;

        			// 배열의 각 객체를 순회하며 Dataset에 데이터 추가
        			dtoArray.forEach(dto => {
        				  var row = dataset.addRow();
        				  dataset.setColumn(row, "codeType", dto.codeType);
        				  dataset.setColumn(row, "num", dto.num);
        				  dataset.setColumn(row, "title", dto.title);
        				  dataset.setColumn(row, "name", dto.name);
        				  dataset.setColumn(row, "regdate", dto.regdate);
        				  dataset.setColumn(row, "content", dto.content);
        			});

        			// 페이지 버튼 세팅
        			console.log(this.pagination);


        		} else {
        			this.alert("Error["+code+"]:"+message);
        		}
        	}



        this.Button00_onclick = function(obj,e)
        {

        };

        });
        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.Static00.addEventHandler("onclick",this.Static00_onclick,this);
            this.Button00.addEventHandler("onclick",this.Button00_onclick,this);
        };
        this.loadIncludeScript("test_form.xfdl");
        this.loadPreloadList();
        
        // Remove Reference
        obj = null;
    };
}
)();
