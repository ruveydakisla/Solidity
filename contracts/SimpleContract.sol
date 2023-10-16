
// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 <0.9.0;
interface IAction {
  function IAmReady () external   returns (string memory);
}
abstract contract Whois{
  function whoAmI() virtual  public returns (string memory);
}
contract RuveydaKisla{
  function getFullName() public pure returns (string memory){
    return "Ruveyda Kisla";
  }
}
contract SimpleContract is IAction,Whois,RuveydaKisla{
bool public allowed; 
uint public count;
int public signedCount;
//string private errorMessage="is not allowed";
string private errorMessage = unicode"bu özellik aktif değill";
mapping(address=>mapping (address=>bool)) public allowence ;
address public owner;
string [] public errorMessages;

struct Account{
   string name;
   string surname;
   uint256 balance;
}
Account public account; //Burayı public yapmazsak aşağıdaki getAccount fonksiyonunu kullanabiliriz

mapping (address=>Account) public AccountValues; //key value olarak hızlı erişim için kullanılır.

Account  [3] public  admins;
uint256 private index;
constructor(address _owner){
   owner = _owner;
   errorMessages.push("is not allowed");
   errorMessages.push("only owner");
   errorMessages.push("deneme");
   

}
function IAmReady() external pure   returns(string memory){
  string  memory _message="I am ready!";
  return _message;
}
function getSizeOfErrorMessages()public view returns (uint256){
return errorMessages.length;
}
function SetAllowed(bool _allowed) public {
    allowed=_allowed;
}

 modifier isAllowed() {
    require(allowence[owner][msg.sender] , errorMessages[0]);
    _;
 }
 modifier  onlyOwner() {
   require(msg.sender==owner,errorMessages[1]);
   _;
 }
 function oneIncrement () public {
    ++count;
 }
 function increment (uint _increment) public isAllowed{
    count+= _increment;
 }
 function signedIncrement (int _increment) public isAllowed{
   signedCount=signedCount+_increment;
 }
 function assignAllowence(address _address) public onlyOwner{
   allowence[owner][_address]=true; 
 }

 function assignValue(Account memory _account) public  {
   account=_account;

    }
 function getAccount() public view returns (Account memory) {
   Account memory _account=account;
   return  _account;
 }
 function assignAddresValues(Account memory _account) public {
   AccountValues[msg.sender]=_account;
 }
 function addAdmin(Account memory _admin)public{
   require(index<3,"has no slot");
   admins[index++]=_admin;
 }
 function gettAllAdmins()  public view returns(Account[3] memory){
  Account[3] memory _admins;
  for(uint i=0;i<3;i++){
    _admins[i]=admins[i];
  }
    return _admins;

 }
 function whoAmI() public override pure    returns (string memory){
  return "I am ruveyda";
 }
 }