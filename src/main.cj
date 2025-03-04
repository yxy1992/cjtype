package cjtype
import std.fs.*
import std.io.*
import std.math.*
import std.binary.*
const VERSION=0.1//版本号
//错误代码
const ok:Int8=1//文件存在
const dzcw:Int8=1//文件不存在
const wjcw:Int8=2//文件非字体文件
const utfzfcw="3"//UTF-8字符检验错误
const fz2z16cw="x"//UTF-8字符编码错误

class cjtype 
{
var ztlj=Path("")
//判断文件地址及内容是否正确
func wjdq(link:String):Int8
{
//判断文件是否存在
if(!exists(link)){return dzcw}
//判断文件是否为字体文件
if(istype(link)!=ok){return wjcw}
ztlj=Path(link)
return ok
}
}

/////////////辅助代码//////////////////////
//简单校验
    func istype(link:String):Int8
    {
    var wj=File(link, OpenOption.Open(true,false))//打开文件
    wj.seek(SeekPosition.Begin(0))//设置文件读取位置
    var zf:Array<Byte>=Array<Byte>(4, repeat: 0)//初始化4个数组成员,并填充0
    wj.read(zf)//读取并填充到数组
    //文件头校验
    if(zf!=[0,1,0,0]){return wjcw}
    return ok
    }
////字符转unicode 
 func Zfzunm(zf:String):String
    {
    var a=zf.toArray()
    var jz2=Array<Int8>(32,repeat:0)
    var ls:Float16=0.0
    ///UTF-8转换为二进制
    println(a)
    println(a.size)
    for(js in 1..a.size+1)
    {
    ls=Float16(a[js-1])/2.0
    
    for(i in 1..9)
    {
        
   if(ls-trunc(ls)>0.0)
   {
    jz2[js*8-i]=1
   }
   else
   {
    jz2[js*8-i]=0
   }
   ls=trunc(ls)/2.0
   
    }
    } 
    println(jz2)
    ///截取组合转换Unicode
    println(a.size)
   match (a.size) {
    case 1 => return fz2z16(jz2[0].toString()+jz2[1].toString()+jz2[2].toString()+jz2[3].toString())+fz2z16(jz2[4].toString()+jz2[5].toString()+jz2[6].toString()+jz2[7].toString())

    case 2 => 
    let a=fz2z16(jz2[0].toString()+jz2[1].toString()+jz2[2].toString()+jz2[3].toString())
    let b=fz2z16(jz2[4].toString()+jz2[5].toString()+jz2[6].toString()+jz2[7].toString())

    return a+b

    case 3 => return fz2z16(jz2[4].toString()+jz2[5].toString()+jz2[6].toString()+jz2[7].toString())+fz2z16(jz2[10].toString()+jz2[11].toString()+jz2[12].toString()+jz2[13].toString())+fz2z16(jz2[14].toString()+jz2[15].toString()+jz2[18].toString()+jz2[19].toString())+fz2z16(jz2[20].toString()+jz2[21].toString()+jz2[22].toString()+jz2[23].toString())

    case 4 => return fz2z16(jz2[0].toString()+jz2[1].toString()+jz2[2].toString()+jz2[3].toString())
    case _ => return ""
   }
    }

//////2转16进制辅助
    func fz2z16(a:String):String {
    match (a) 
    {
    case "0000" => return "0"
    case "0001" => return "1"
    case "0010" => return "2"
    case "0011" => return "3"
    case "0100" => return "4"
    case "0101" => return "5"
    case "0110" => return "6"
    case "0111" => return "7"
    case "1000" => return "8"
    case "1001" => return "9"
    case "1010" => return "A"
    case "1011" => return "B"
    case "1100" => return "C"
    case "1101" => return "D"
    case "1110" => return "E"
    case "1111" => return "F"
    case _ => return fz2z16cw          
    }
    }
///////////////////代码测试/////////////////////////////
main(): Int64 {
    var zt=cjtype()
    
    zt.wjdq("./MiSans-Medium.ttf")
    println(169>>6)
    //println(Zfzunm("A"))
   //println(Zfzunm("*"))
    println(Zfzunm("é"))

  // println(Zfzunm("中"))

   //println(Zfzunm("🐉"))
   
    
    return 0
}