<%@ page language="java" pageEncoding="UTF-8" import="com.alphaking.webSocket.WebSocketMessageServlet"%>  
<%  
    String user = (String)session.getAttribute("user");  
    if(user == null){  
        //为用户生成昵称  
        user = "游客" + WebSocketMessageServlet.ONLINE_USER_COUNT;  
        WebSocketMessageServlet.ONLINE_USER_COUNT ++;  
        session.setAttribute("user", user);  
    }  
    pageContext.setAttribute("user", user);  
%>  
<html>  
<head>  
    <title>金明同达灯饰 聊天室</title>
    <!-- 引入CSS文件 -->  
      
    <!-- 映入Ext的JS开发包，及自己实现的webscoket. -->  
    <script type="text/javascript" src="ext4/ext-all-debug.js"></script>  
    <script type="text/javascript" src="websocket.js"></script>  
    <script type="text/javascript">  
        var user = "${user}";  
    </script>  
</head>  
  
<body>  
    <h1>WebSocket聊天室</h1>  
    <p>通过HTML5标准提供的API与Ext富客户端框架相结合起来，实现聊天室，有以下特点：</p>  
    <ul class="feature-list" style="padding-left: 10px;">  
        <li>实时获取数据，由服务器推送，实现即时通讯</li>  
        <li>利用WebSocket完成数据通讯，区别于轮询，长连接等技术，节省服务器资源</li>  
        <li>结合Ext进行页面展示</li>  
        <li>用户上线下线通知</li>  
    </ul>  
    <div id="websocket_button"></div>  
    <script>
  /* //用于展示用户的聊天信息  
    Ext.define('MessageContainer', {  
      
        extend : 'Ext.view.View',  
      
        trackOver : true,  
      
        multiSelect : false,  
      
        itemCls : 'l-im-message',  
      
        itemSelector : 'div.l-im-message',  
      
        overItemCls : 'l-im-message-over',  
      
        selectedItemCls : 'l-im-message-selected',  
      
        style : {  
            overflow : 'auto',  
            backgroundColor : '#fff'  
        },  
      
        tpl : [  
                '<div class="l-im-message-warn">​交谈中请勿轻信汇款、中奖信息、陌生电话。 请遵守相关法律法规。</div>',  
                '<tpl for=".">',  
                '<div class="l-im-message">',  
                '<div class="l-im-message-header l-im-message-header-{source}">{from}  {timestamp}</div>',  
                '<div class="l-im-message-body">{content}</div>', '</div>',  
                '</tpl>'],  
      
        messages : [],  
      
        initComponent : function() {  
            var me = this;  
            me.messageModel = Ext.define('Leetop.im.MessageModel', {  
                        extend : 'Ext.data.Model',  
                        fields : ['from', 'timestamp', 'content', 'source']  
                    });  
            me.store = Ext.create('Ext.data.Store', {  
                        model : 'Leetop.im.MessageModel',  
                        data : me.messages  
                    });  
            me.callParent();  
        },  
      
        //将服务器推送的信息展示到页面中  
        receive : function(message) {  
            var me = this;  
            message['timestamp'] = Ext.Date.format(new Date(message['timestamp']),  
                    'H:i:s');  
            if(message.from == user){  
                message.source = 'self';  
            }else{  
                message.source = 'remote';  
            }  
            me.store.add(message);  
            if (me.el.dom) {  
                me.el.dom.scrollTop = me.el.dom.scrollHeight;  
            }  
        }  
    });  
  
    Ext.onReady(function() {  
                //创建用户输入框  
                var input = Ext.create('Ext.form.field.HtmlEditor', {  
                            region : 'south',  
                            height : 120,  
                            enableFont : false,  
                            enableSourceEdit : false,  
                            enableAlignments : false,  
                            listeners : {  
                                initialize : function() {  
                                    Ext.EventManager.on(me.input.getDoc(), {  
                                                keyup : function(e) {  
                                                    if (e.ctrlKey === true  
                                                            && e.keyCode == 13) {  
                                                        e.preventDefault();  
                                                        e.stopPropagation();  
                                                        send();  
                                                    }  
                                                }  
                                            });  
                                }  
                            }  
                        });  
                //创建消息展示容器  
                var output = Ext.create('MessageContainer', {  
                            region : 'center'  
                        });  
      
                var dialog = Ext.create('Ext.panel.Panel', {  
                            region : 'center',  
                            layout : 'border',  
                            items : [input, output],  
                            buttons : [{  
                                        text : '发送',  
                                        handler : send  
                                    }]  
                        });  
                var websocket;  
      
                //初始话WebSocket  
                function initWebSocket() {  
                    if (window.WebSocket) {  
                        websocket = new WebSocket(encodeURI('ws://localhost:8080/WebSocket/message'));  
                        websocket.onopen = function() {  
                            //连接成功  
                            win.setTitle(title + '  (已连接)');  
                        }  
                        websocket.onerror = function() {  
                            //连接失败  
                            win.setTitle(title + '  (连接发生错误)');  
                        }  
                        websocket.onclose = function() {  
                            //连接断开  
                            win.setTitle(title + '  (已经断开连接)');  
                        }  
                        //消息接收  
                        websocket.onmessage = function(message) {  
                            var message = JSON.parse(message.data);  
                            //接收用户发送的消息  
                            if (message.type == 'message') {  
                                output.receive(message);  
                            } else if (message.type == 'get_online_user') {  
                                //获取在线用户列表  
                                var root = onlineUser.getRootNode();  
                                Ext.each(message.list,function(user){  
                                    var node = root.createNode({  
                                        id : user,  
                                        text : user,  
                                        iconCls : 'user',  
                                        leaf : true  
                                    });  
                                    root.appendChild(node);  
                                });  
                            } else if (message.type == 'user_join') {  
                                //用户上线  
                                    var root = onlineUser.getRootNode();  
                                    var user = message.user;  
                                    var node = root.createNode({  
                                        id : user,  
                                        text : user,  
                                        iconCls : 'user',  
                                        leaf : true  
                                    });  
                                    root.appendChild(node);  
                            } else if (message.type == 'user_leave') {  
                                    //用户下线  
                                    var root = onlineUser.getRootNode();  
                                    var user = message.user;  
                                    var node = root.findChild('id',user);  
                                    root.removeChild(node);  
                            }  
                        }  
                    }  
                };  
      
                //在线用户树  
                var onlineUser = Ext.create('Ext.tree.Panel', {  
                            title : '在线用户',  
                            rootVisible : false,  
                            region : 'east',  
                            width : 150,  
                            lines : false,  
                            useArrows : true,  
                            autoScroll : true,  
                            split : true,  
                            iconCls : 'user-online',  
                            store : Ext.create('Ext.data.TreeStore', {  
                                        root : {  
                                            text : '在线用户',  
                                            expanded : true,  
                                            children : []  
                                        }  
                                    })  
                        });  
                var title = '欢迎您：' + user;  
                //展示窗口  
                var win = Ext.create('Ext.window.Window', {  
                            title : title + '  (未连接)',  
                            layout : 'border',  
                            iconCls : 'user-win',  
                            minWidth : 650,  
                            minHeight : 460,  
                            width : 650,  
                            animateTarget : 'websocket_button',  
                            height : 460,  
                            items : [dialog,onlineUser],  
                            border : false,  
                            listeners : {  
                                render : function() {  
                                    initWebSocket();  
                                }  
                            }  
                        });  
      
                win.show();  
      
                //发送消息  
                function send() {  
                    var message = {};  
                    if (websocket != null) {  
                        if (input.getValue()) {  
                            Ext.apply(message, {  
                                        from : user,  
                                        content : input.getValue(),  
                                        timestamp : new Date().getTime(),  
                                        type : 'message'  
                                    });  
                            websocket.send(JSON.stringify(message));  
                            //output.receive(message);  
                            input.setValue('');  
                        }  
                    } else {  
                        Ext.Msg.alert('提示', '您已经掉线，无法发送消息!');  
                    }  
                }  
            });   */
            initWebSocket();
          //初始话WebSocket  
            function initWebSocket() {  
                if (window.WebSocket) {  
                    websocket = new WebSocket(encodeURI('ws://localhost:8080/findeng/message'));  
                    websocket.onopen = function() {  
                        //连接成功  
                        console.log('  (已连接)');  
                    }  
                    websocket.onerror = function() {  
                        //连接失败  
                         console.log( '  (连接发生错误)');  
                    }  
                    websocket.onclose = function() {  
                        //连接断开  
                         console.log( '  (已经断开连接)');  
                    }  
                    //消息接收  
                    websocket.onmessage = function(message) {  
                        console.log(message)
                        var message1 =  eval("(" + message.data + ")"); 
                        //接收用户发送的消息  
                        
                        console.log(message1)
                        console.log(message1.infoContent)
                    }  
                }  
            };  
            
            function send() {  
                var message = {};  
                if (websocket != null) {  
                       var message={  
                                    from : user,  
                                    content : "11",  
                                    timestamp : new Date().getTime(),  
                                    type : 'message'  
                                };  
                        websocket.send(JSON.stringify(message));  
                        //output.receive(message);  
                } else {  
                   alert('提示', '您已经掉线，无法发送消息!');  
                }  
            }  
    </script>
</body>  
</html>  