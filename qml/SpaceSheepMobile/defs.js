.import QtQuick 2.1 as Quick

//dimension in pixels of the ship
var shipxsize=   89;
var shipysize=   38;

//the dimension of the bullet in pixels
var bullet_x_size=       54;
var bullet_y_size=       8;
//the dimension of the metheor in pixels
var sxmet=               200;//99;
var symet=               200;//103;
//how many frames for the metheor animation
var frameMeteor=     5;

//dimension in pixels of the explosion image
var sxbom=   70;
var sybom=   99;
//how many frames for the explosion animation
var bframes= 4;

//bullet speed coefficient
var bulletSpeedCoeff=    20;

var maxshield=   9;

//width of the border (i dont use borders)
var borderWindowWidth=   0;

//the height of the score bar
var scoreheight=     45;

var screendelay=     300;
var movex=           5;
var movey=           5;
var txtalign=        100;
var backcol=         0x102040;

var regenerationTimeMax=     11000;

var heigtFactor=600;
//var actualHeight=heigtFactor;

//-------------------------------------------------------------------------------------

/*function scaledDim(oldDim,winH)
{
    //console.log(winH);
    //console.log((main_window.height*oldDim)/heigtFactor);
    if(winH===null)winH=actualHeight;
    if(winH===undefined)winH=actualHeight;
    var retV= (winH*oldDim)/heigtFactor;
    if(retV==null)
    {
        console.log("null")
        return oldDim;
    }
    if(retV<=0)return oldDim;
    return retV;
}*/

//-------------------------------------------------------------------------------------

function randomNumber()
{
    return Math.floor(Math.random() * (main_window.width-sxmet));
}

//-------------------------------------------------------------------------------------

function randomNumberX(x)
{
    return Math.floor(Math.random() * (x));
}

//-------------------------------------------------------------------------------------

function randomRebornX(x)
{
    return (Math.floor(Math.random() * (x)))-75;
}

//-------------------------------------------------------------------------------------

function randomRebornTime(x)
{
    var time=Math.floor(Math.random() * (x));
    if (time<700)
        time=700;
    return time;
}

//-------------------------------------------------------------------------------------

function shipMoveX(left)
{
    //console.log("shipMoveX")
    var x=space_ship.x;
    if(left)
    {
        if((x-11)<0)
            return 0;
        return x-11;
    }
    else
    {        
        if((x+11)>main_window.width-space_ship.width)
            return main_window.width-space_ship.width;
        return x+11;
    }
}

//-------------------------------------------------------------------------------------

function shipMoveY(up)
{
    var x=space_ship.y;
    if(up)
    {
        if((x-11)<0)
            return 0;
        return x-11;
    }
    else
    {
        if((x+11)>main_window.height-space_ship.height-toolBar.height)
            return main_window.height-space_ship.height-toolBar.height;
        return x+11;
    }
}

//-------------------------------------------------------------------------------------

function shipMoveXV(value)
{
    //console.log(value);
    var x=space_ship.x;
    if(value<0.0)
    {
        if((x+value)<=0)
            return 0;
    }
    else
    {
        if((x+value)>main_window.width-space_ship.width)
            return main_window.width-space_ship.width;
    }
    return x+value;
}

//-------------------------------------------------------------------------------------

function shipMoveYV(value)
{
    //if(value==0 || _device.indexOf("pc") != -1)
    //    return space_ship.x;

    //console.log(value);
    value=value+30;
    var x=space_ship.y;
    //console.log(value +"   height:"+main_window.height);
    if(value<0.0)
    {
        if((x+value)<=0)
            return 0;
    }
    else
    {
        if((x+value)>=main_window.height-space_ship.height-toolBar.height)
            return main_window.height-space_ship.height-toolBar.height;
    }
    return x+value;
}

//-------------------------------------------------------------------------------------

//var component;
var maxStars=44
var stars = new Array(maxStars);
var colors = ["yellow","red","blue","green","purple","white"];
var starDimensions = [7,"red","blue","green","purple","white"];
function createStar(component,i,wid,hei)
{
    var dynamicObject;
    if (component == null)
    {
        component = Qt.createComponent("Star.qml");

        // Note that if Star.qml was not a local file, component.status would be
        // Loading and we should wait for the component's statusChanged() signal to
        // know when the file is downloaded and ready before calling createObject().
        if (component.status == Quick.Component.Ready)
        {
            dynamicObject = component.createObject(main_window);    //component.createObject(parent, {"x": 100, "y": 100});
            if (dynamicObject == null)
            {
                console.log("error creating star");
                console.log(component.errorString());
                return false;
            }
            //dynamicObject.type =
            dynamicObject.x = Math.floor(Math.random() * wid);
            dynamicObject.y = Math.floor(Math.random() * hei);
            dynamicObject.z = 0;
            dynamicObject.theColor=colors[Math.floor(Math.random() * colors.length)];
            dynamicObject.width = Math.floor(Math.random() * 10) +4;
            //dynamicObject.height = gameCanvas.blockSize;
            //dynamicObject.spawned = true;

            //board[index(column, row)] = dynamicObject;
        }
        else
        {
            console.log("error loading block component");
            console.log(component.errorString());
            return false;
        }
        stars[i]=dynamicObject;
    }
    else
    {
        dynamicObject=stars[i];
        var newY=dynamicObject.y+4;
        if(newY>hei)
        {
            dynamicObject.x = Math.floor(Math.random() * wid);
            dynamicObject.y = 0;
            dynamicObject.z = 0;
            dynamicObject.theColor=colors[Math.floor(Math.random() * colors.length)];
            dynamicObject.width = Math.floor(Math.random() * 10) +4;
        }
        else
            dynamicObject.y=newY;
    }

    return true;
}

//-------------------------------------------------------------------------------------

function createStarField(wid,hei)
{
   /* if(actualHeight!=parent.height)
        actualHeight=parent.height;
*/
    for(var i=0;i<(parent.height*maxStars)/heigtFactor;i++)
    {
        var component=stars[i];
        createStar(component,i,wid,hei);
    }
}

//-------------------------------------------------------------------------------------

var device;
/*function setDevice(device)
{
    if(device==="ios" || device==="android" || device==="symbian" || device==="blackberry" || device==="linuxpc" || device==="macpc" || device==="windowspc")
        _device=device;
    else
        _device=null;
    return _device;
}

function device()
{
    return _device;
}*/

//-------------------------------------------------------------------------------------
