pragma solidity >=0.7.0 <0.9.0;

contract BlockChainGame_Contract {
    // 合約資產
    uint totalFixCount;
    string message;
    address lastFixAddress;
    mapping (address => uint) fixCountMap; //每個人修改幾次

    // modifier
    modifier FixCountLowerThan10(uint _number) { // 只能修改10次
        require(fixCountMap[msg.sender] < _number);
        _;
    }

    // event
    // 當有新訊息的時候，可以把資料發送給前端
    event NewMessageEvent(
        string _message;
    );

    // 建構子(初始化的概念)
    constructor (string memory _message) public {
        totalFixCount = 0;
        // message = "";
        message = _message;

        // msg.sender發布人
        lastFixAddress = msg.sender;
    }

    // 合約的功能(修改 & 取值) - 放上modifier限制次數
    function UpdateMesage(string memory _message) FixCountLowerThan10(10) public {
        // modifier也可以直接加在裡面，不需使用 _;
        // require(fixCountMap[msg.sender] < 3);

        message = _message;
        lastFixAddress = msg.sender;
        totalFixCount = totalFixCount + 1;
        fixCountMap[msg.sender] = fixCountMap[msg.sender] + 1;

        /*前端可以拿到資料*/
        emit NewMessageEvent(message);
    }
    function GetMessage() public view returns(string memory){
        return message;
    }
    function GetMyFixCount() public view returns(uint) {
        return fixCountMap[msg.sender];
    }
    function GetLastAddress() public view returns(address) {
        return lastFixAddress;
    }
}