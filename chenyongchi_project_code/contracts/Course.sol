// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.6.2 <0.7.0;


contract Course {
    
    //  管理员
    address public owner;

    // 课程id & 年份 => 课程ipfs hash
    mapping (bytes32 => string) courses;

    // 课程id & 年份 => 课程ID
    mapping (bytes32 => string) courseIds;

    // 课程id & 年份 => 课程Year
    mapping (bytes32 => uint256) courseYear;

    // 课程id & 年份 => 课程上传时间
    mapping (bytes32 => uint256) courseTime;
    
    
    bytes32[] byteHashs;

    // 权限
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    
    constructor() public {
        owner = msg.sender;
    }
    
    // 通过课程id和年份设置 课程ipfs hash
    // 课程id与年份 生成一个byte32 hash值作为key, 课程ipfs hash作为value 存储
    function setCourse(string memory courseId, uint256 year, string memory hash) public onlyOwner {
        bytes32 byteHash = keccak256(abi.encodePacked(courseId, keccak256(abi.encodePacked(year))));
        courses[byteHash] = hash;
        courseIds[byteHash] = courseId;
        courseYear[byteHash] = year;
        courseTime[byteHash] = now;

        byteHashs.push(byteHash);
    }

    // 通过课程id和年份获取。课程ipfs hash
    function getCourse(string memory courseId, uint256 year) view public returns(string memory) {
        bytes32 byteHash = keccak256(abi.encodePacked(courseId, keccak256(abi.encodePacked(year))));
        return courses[byteHash];
    }
    
    // 通过索引遍历课程记录， 依次返回年份，时间，课程ID， 课程ipfs hash
    function listCourse(uint256 index) view public returns( uint256,  uint256, string memory, string memory) {
        bytes32 byteHash = byteHashs[index];
        return (
            courseYear[byteHash],
            courseTime[byteHash],
            courseIds[byteHash],
            courses[byteHash]
            );
    }
    
    // 课程记录 数据量
    function coursesLength() view public returns(uint256) {
        return byteHashs.length;
    }

    // 转移权限
    function changeOwner(address newOwner) public onlyOwner {
        owner = newOwner;
    }
    
}