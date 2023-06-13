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
            this.set_color("black");
            this.set_opacity("1");
            if (Form == this.constructor)
            {
                this._setFormPosition(1280,720);
            }
            
            // Object(Dataset, ExcelExportObject) Initialize
            obj = new Dataset("Dataset00", this);
            obj._setContents("<ColumnInfo><Column id=\"codeType\" type=\"STRING\" size=\"10\"/><Column id=\"num\" type=\"INT\" size=\"10\"/><Column id=\"name\" type=\"STRING\" size=\"100\"/><Column id=\"title\" type=\"STRING\" size=\"100\"/><Column id=\"content\" type=\"STRING\" size=\"100\"/><Column id=\"regdate\" type=\"STRING\" size=\"8\"/></ColumnInfo>");
            this.addChild(obj.name, obj);


            obj = new Dataset("Dataset01", this);
            obj._setContents("<ColumnInfo><Column id=\"typeNum\" type=\"STRING\" size=\"256\"/><Column id=\"typeText\" type=\"STRING\" size=\"256\"/></ColumnInfo><Rows><Row><Col id=\"typeNum\">00</Col><Col id=\"typeText\">전체</Col></Row><Row><Col id=\"typeNum\">01</Col><Col id=\"typeText\">자유</Col></Row><Row><Col id=\"typeNum\">02</Col><Col id=\"typeText\">익명</Col></Row><Row><Col id=\"typeNum\">03</Col><Col id=\"typeText\">QnA</Col></Row></Rows>");
            this.addChild(obj.name, obj);
            
            // UI Components Initialize
            obj = new Static("Static00","314","14","93","66",null,null,null,null,null,null,this);
            obj.set_taborder("0");
            obj.set_text("FreeBoard");
            obj.set_textAlign("center");
            obj.set_color("#040e29");
            this.addChild(obj.name, obj);

            obj = new Grid("Grid00","117","154","483","148",null,null,null,null,null,null,this);
            obj.set_taborder("1");
            obj.set_binddataset("Dataset00");
            obj._setContents("<Formats><Format id=\"default\"><Columns><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/><Column size=\"80\"/></Columns><Rows><Row band=\"head\" size=\"24\"/><Row size=\"24\"/></Rows><Band id=\"head\"><Cell text=\"codeType\"/><Cell col=\"1\" text=\"num\"/><Cell col=\"2\" text=\"name\"/><Cell col=\"3\" text=\"title\"/><Cell col=\"4\" text=\"content\"/><Cell col=\"5\" text=\"regdate\"/></Band><Band id=\"body\"><Cell text=\"bind:codeType\"/><Cell col=\"1\" text=\"bind:num\"/><Cell col=\"2\" text=\"bind:name\"/><Cell col=\"3\" text=\"bind:title\"/><Cell col=\"4\" text=\"bind:content\"/><Cell col=\"5\" text=\"bind:regdate\"/></Band></Format></Formats>");
            this.addChild(obj.name, obj);

            obj = new Button("pageBtn01","290","320","20","20",null,null,null,null,null,null,this);
            obj.set_taborder("2");
            obj.set_color("cadetblue");
            this.addChild(obj.name, obj);

            obj = new Button("pageBtn02","320","320","20","20",null,null,null,null,null,null,this);
            obj.set_taborder("3");
            obj.set_color("cadetblue");
            this.addChild(obj.name, obj);

            obj = new Button("pageBtn03","350","320","20","20",null,null,null,null,null,null,this);
            obj.set_taborder("4");
            obj.set_color("cadetblue");
            this.addChild(obj.name, obj);

            obj = new Button("pageBtn04","380","320","20","20",null,null,null,null,null,null,this);
            obj.set_taborder("5");
            obj.set_color("cadetblue");
            this.addChild(obj.name, obj);

            obj = new Button("pageBtn05","407","320","20","20",null,null,null,null,null,null,this);
            obj.set_taborder("6");
            obj.set_color("cadetblue");
            this.addChild(obj.name, obj);

            obj = new Static("Static01","105","80","50","25",null,null,null,null,null,null,this);
            obj.set_taborder("7");
            obj.set_text("타입");
            obj.set_color("black");
            obj.set_textAlign("center");
            obj.set_verticalAlign("top");
            this.addChild(obj.name, obj);

            obj = new Static("Static01_00","245","80","50","25",null,null,null,null,null,null,this);
            obj.set_taborder("8");
            obj.set_text("글번호");
            obj.set_color("black");
            obj.set_textAlign("center");
            obj.set_verticalAlign("top");
            this.addChild(obj.name, obj);

            obj = new Edit("searchNum","291","76","75","25",null,null,null,null,null,null,this);
            obj.set_taborder("9");
            obj.set_color("black");
            this.addChild(obj.name, obj);

            obj = new Static("Static01_00_00","365","80","50","25",null,null,null,null,null,null,this);
            obj.set_taborder("10");
            obj.set_text("제목");
            obj.set_color("black");
            obj.set_textAlign("center");
            obj.set_verticalAlign("top");
            this.addChild(obj.name, obj);

            obj = new Edit("searchTitle","411","76","75","25",null,null,null,null,null,null,this);
            obj.set_taborder("11");
            obj.set_color("black");
            this.addChild(obj.name, obj);

            obj = new Static("Static01_00_00_00","485","80","50","25",null,null,null,null,null,null,this);
            obj.set_taborder("12");
            obj.set_text("내용");
            obj.set_color("black");
            obj.set_textAlign("center");
            obj.set_verticalAlign("top");
            this.addChild(obj.name, obj);

            obj = new Edit("searchContent","531","76","75","25",null,null,null,null,null,null,this);
            obj.set_taborder("13");
            obj.set_color("black");
            this.addChild(obj.name, obj);

            obj = new Static("Static01_01","105","110","50","25",null,null,null,null,null,null,this);
            obj.set_taborder("14");
            obj.set_text("작성자");
            obj.set_color("black");
            obj.set_textAlign("center");
            obj.set_verticalAlign("top");
            this.addChild(obj.name, obj);

            obj = new Edit("searchWriter","151","106","85","25",null,null,null,null,null,null,this);
            obj.set_taborder("15");
            obj.set_color("black");
            this.addChild(obj.name, obj);

            obj = new Static("Static01_00_00_01","245","110","50","25",null,null,null,null,null,null,this);
            obj.set_taborder("16");
            obj.set_text("기간");
            obj.set_color("black");
            obj.set_textAlign("center");
            obj.set_verticalAlign("top");
            this.addChild(obj.name, obj);

            obj = new Calendar("searchDate_begin","290","106","105","25",null,null,null,null,null,null,this);
            obj.set_taborder("17");
            obj.set_color("black");
            this.addChild(obj.name, obj);

            obj = new Calendar("searchDate_end","410","106","105","25",null,null,null,null,null,null,this);
            obj.set_taborder("18");
            obj.set_color("black");
            this.addChild(obj.name, obj);

            obj = new Static("Static01_00_00_01_00","385","110","36","25",null,null,null,null,null,null,this);
            obj.set_taborder("19");
            obj.set_text("~");
            obj.set_color("black");
            obj.set_textAlign("center");
            obj.set_verticalAlign("top");
            this.addChild(obj.name, obj);

            obj = new Button("searchBtn","540","107","65","25",null,null,null,null,null,null,this);
            obj.set_taborder("20");
            obj.set_text("검색");
            obj.set_color("white");
            obj.set_font("bold 12px/normal \"Gulim\",\"Arial Black\"");
            obj.set_textAlign("center");
            obj.set_verticalAlign("middle");
            obj.set_background("cadetblue");
            this.addChild(obj.name, obj);

            obj = new Combo("Combo00","150","75","85","25",null,null,null,null,null,null,this);
            obj.set_taborder("21");
            obj.set_innerdataset("Dataset01");
            obj.set_codecolumn("typeNum");
            obj.set_datacolumn("typeText");
            obj.set_text("Combo00");
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

        	// 페이지 로드 시 실행
        	this.test_form_onload = function(obj,e) {

        		let id = "";
        		let url = "/nexa.ino";
        		let reqDs = "";
        		let respDs = "";
        		let args = "";
        		let callback = "received";

        		// 서버에서 전송하는 키값
        		this.data = "";
        		this.pagination = "";

        		this.transaction(id, url, reqDs, respDs, args, callback);

        		this.received = function(id, code, message)
        		{
        			if (code == 0) {

        				// console.log("code: "+ code + " message: " + message);
        				const responseString = this.data;
        				// console.log("원본 문자열: "+responseString);

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
        				// console.log(this.pagination);
        				// 파싱
        				const res_btn_String = this.pagination;
        				let temp = {};

        				const regex = /(\w+)\s*\[([^]+?)\]/;
        				const match = res_btn_String.match(regex);

        				if (match) {
        				  const key = match[1];
        				  const valuesStr = match[2];
        				  const valuesRegex = /(\w+)\s*=\s*([^,]+)/g;
        				  let valuesMatch;
        				  temp = { [key]: {} };

        				  while ((valuesMatch = valuesRegex.exec(valuesStr))) {
        					const name = valuesMatch[1];
        					const value = valuesMatch[2].trim();
        					temp[key][name] = value;
        				  }

        				  // console.log(page_btn);
        				}
        				const pagination = temp.Pagination;

        				// 페이지 버튼 가져오기
        				const pageBtnArr = [this.pageBtn01, this.pageBtn02, this.pageBtn03, this.pageBtn04, this.pageBtn05];
        				let btnNum = pagination.blockStart;

        				pageBtnArr.forEach((btn) => {
        					btn.set_text(btnNum++);
        				});

        			} else {
        				this.alert("Error["+code+"]:"+message);
        			}
        		}
        	};




        	this.searchBtn_onclick = function(obj,e)
        	{
        		let searchType = this.Combo00.value;
        		let searchNum = this.searchNum.value;
        		let searchTitle = this.searchTitle.value;
        		let searchContent = this.searchContent.value;
        		let searchName = this.searchWriter.value;
        		let beginDate = this.searchDate_begin.value;
        		let endDate = this.searchDate_end.value;
        		console.log(searchType);
        		console.log(searchNum);
        		console.log(searchTitle);
        		console.log(searchContent);
        		console.log(searchName);
        		console.log(beginDate);
        		console.log(endDate);
        	};

        });
        
        // Regist UI Components Event
        this.on_initEvent = function()
        {
            this.addEventHandler("onload",this.test_form_onload,this);
            this.Static01.addEventHandler("onclick",this.Static01_onclick,this);
            this.Static01_00.addEventHandler("onclick",this.Static01_onclick,this);
            this.searchNum.addEventHandler("onchanged",this.Edit00_onchanged,this);
            this.Static01_00_00.addEventHandler("onclick",this.Static01_onclick,this);
            this.searchTitle.addEventHandler("onchanged",this.Edit00_onchanged,this);
            this.Static01_00_00_00.addEventHandler("onclick",this.Static01_onclick,this);
            this.searchContent.addEventHandler("onchanged",this.Edit00_onchanged,this);
            this.Static01_01.addEventHandler("onclick",this.Static01_onclick,this);
            this.searchWriter.addEventHandler("onchanged",this.Edit00_onchanged,this);
            this.Static01_00_00_01.addEventHandler("onclick",this.Static01_onclick,this);
            this.Static01_00_00_01_00.addEventHandler("onclick",this.Static01_onclick,this);
            this.searchBtn.addEventHandler("onclick",this.searchBtn_onclick,this);
        };
        this.loadIncludeScript("test_form.xfdl");
        this.loadPreloadList();
        
        // Remove Reference
        obj = null;
    };
}
)();
