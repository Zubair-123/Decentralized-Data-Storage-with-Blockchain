pragma solidity ^0.6.8;

contract Factory{
    mapping(bytes32 =>bytes32) public node;
    mapping(bytes32 =>address) public user;
    
    
    struct activeNodeStruct {
        bytes32 nodeID;
        string ipAddress;
    }
    
    // struct Request{
    //     address userInstanceAddress;
    //     bool status;
        
    // }
    
   
    activeNodeStruct[] public activeNode;
    
     function getSummary() view  public returns(uint){
        return activeNode.length;
    }
    
    
    function nodeSignUp(bytes32 hash)public {
        require(node[hash] == 0x0);
        node[hash]=hash;
    }
    
    function userSignUp (bytes32 hash) public{
        require(user[hash] == address(0));
        address newUser= address(new userInstance(msg.sender));
        user[hash] =newUser ;
    }
    
    function  nodeSignIn(bytes32  hash ,string memory  ipAddress) public  returns(bytes32){
        require(node[hash] !=0x0);
        activeNodeStruct memory newActiveNode = activeNodeStruct({
           nodeID: node[hash],
           ipAddress: ipAddress
           
        });
        
        activeNode.push(newActiveNode);
        
        return node[hash] ;
    }
    
    
    function userSignIn(bytes32 hash) public view returns(address){
        require(user[hash] != address(0));
        return user[hash];
    }
    
    function nodeSignOut(uint index) public {
        require(!(index >= activeNode.length)) ;
        
        for (uint i = index; i<activeNode.length-1; i++){
            activeNode[i] = activeNode[i+1];
        }
        activeNode.pop();
        // delete activeNode[activeNode.length-1];
        // activeNode.length--;
    }
    
    
}


contract userInstance {
    
    address user_address;
    
    
    struct fileDetails{
            string fileName;
            string Part1_1;
            string Part1_2;
            string Part1_3;
            string Part2_1;
            string Part2_2;
            string Part2_3;
                }
                
    struct fileDetails2{
            string fileName;
            string Part3_1;
            string Part3_2;
            string Part3_3;
            
    }
                
     fileDetails[] public Part1_2_Details;
     fileDetails2[] public Part3_Details;
     
    function setFileDetailsOfPart1_2(string memory filename,string memory part1_1,string memory part1_2
    ,string memory part1_3,string memory part2_1,string memory part2_2,string memory part2_3) public {
        
    fileDetails memory newFile=fileDetails({
       fileName:filename,
       Part1_1: part1_1,
       Part1_2: part1_2,
       Part1_3: part1_3,
       Part2_1: part2_1,
       Part2_2: part2_2,
       Part2_3: part2_3
       
    });
    
    Part1_2_Details.push(newFile);
    }
    
    
    
    function setFileDetailsOfPart3(string memory filename,string memory part3_1,string memory part3_2
    ,string memory part3_3)public{
        
    fileDetails2 memory newFile=fileDetails2({
       fileName:filename,
       Part3_1: part3_1,
       Part3_2: part3_2,
       Part3_3: part3_3
      
       
    });
    
    Part3_Details.push(newFile);
        
    }
 
    constructor (address creator) public {
        user_address= creator;
    }
    
    function getNumberOffiles() view public returns(uint){
        return Part1_2_Details.length;
    }
    
}
