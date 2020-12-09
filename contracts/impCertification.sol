pragma solidity ^0.5.11;

contract impCertification {
    address public manager;
    string  public organisation;
    constructor(address client,string memory org) public
    {

        manager=client;
        organisation=org;
    }

    struct Certificate {
        string student_name;
        string org_name;
        string course_name;
        uint256 expiration_date;
    }
     modifier onlyManager()
    {
        require(msg.sender==manager);
        _;
    }


    mapping(bytes32 => Certificate) public certificates;

    event certificateGenerated(bytes32 _certificateId);

    function converttobytes(string memory source) private pure returns (bytes32 result) {
        bytes memory tempEmptyStringTest = bytes(source);
        if (tempEmptyStringTest.length == 0) {
            return 0x0;
        }
        assembly {
                result := mload(add(source, 32))
        }
    }

    function storeCertificate(
        string memory _id,
        string memory _student_name,
        string memory _course_name,
        uint256 _expiration_date) public onlyManager
        {
        bytes32 byte_id = converttobytes(_id);
        require(certificates[byte_id].expiration_date == 0, "Duplicate Entry");
        certificates[byte_id] = Certificate(_student_name, organisation, _course_name, _expiration_date);
        emit certificateGenerated(byte_id);
        }

        function verifyCertificate(string memory _id) public view returns(string memory)
       {
           bytes32 byte_id = converttobytes(_id);
           Certificate memory temp = certificates[byte_id];
           require(temp.expiration_date != 0, "No such certificate exists");
           return ("Yes the certificate exists");
       }
        function getCertificate(string memory _id) public view returns(string memory, string memory, string memory, uint256)
       {
           bytes32 byte_id = converttobytes(_id);
           Certificate memory temp = certificates[byte_id];
           require(temp.expiration_date != 0, "No such certificate exists");
           return (temp.student_name, temp.org_name, temp.course_name, temp.expiration_date);
       }
}
