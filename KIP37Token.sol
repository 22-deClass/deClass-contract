
pragma solidity ^0.5.0;

/*
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with GSN meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
contract Context {
    // Empty internal constructor, to prevent people from mistakenly deploying
    // an instance of this contract, which should be used via inheritance.
    constructor () internal { }
    // solhint-disable-previous-line no-empty-blocks

    function _msgSender() internal view returns (address payable) {
        return msg.sender;
    }

    function _msgData() internal view returns (bytes memory) {
        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
        return msg.data;
    }
}

// File: contracts/math/SafeMath.sol

pragma solidity ^0.5.0;

/**
 * @dev Wrappers over Solidity's arithmetic operations with added overflow
 * checks.
 *
 * Arithmetic operations in Solidity wrap on overflow. This can easily result
 * in bugs, because programmers usually assume that an overflow raises an
 * error, which is the standard behavior in high level programming languages.
 * `SafeMath` restores this intuition by reverting the transaction when an
 * operation overflows.
 *
 * Using this library instead of the unchecked operations eliminates an entire
 * class of bugs, so it's recommended to use it always.
 */
library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     * - Subtraction cannot overflow.
     *
     * _Available since v2.4.0._
     */
    function sub(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     *
     * _Available since v2.4.0._
     */
    function div(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        // Solidity only automatically asserts when dividing by 0
        require(b > 0, errorMessage);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts with custom message when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     *
     * _Available since v2.4.0._
     */
    function mod(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

// File: contracts/utils/Address.sol

pragma solidity ^0.5.0;

/**
 * @dev Collection of functions related to the address type,
 */
library Address {
    /**
     * @dev Returns true if `account` is a contract.
     *
     * This test is non-exhaustive, and there may be false-negatives: during the
     * execution of a contract's constructor, its address will be reported as
     * not containing a contract.
     *
     * > It is unsafe to assume that an address for which this function returns
     * false is an externally-owned account (EOA) and not a contract.
     */
    function isContract(address account) internal view returns (bool) {
        // This method relies in extcodesize, which returns 0 for contracts in
        // construction, since the code is only stored at the end of the
        // constructor execution.

        uint256 size;
        // solhint-disable-next-line no-inline-assembly
        assembly {
            size := extcodesize(account)
        }
        return size > 0;
    }
}

pragma solidity ^0.5.0;
library addressArrayUtils {  

    function reverse(address[] storage a) internal returns (address[] storage) {
        address t;
        for (uint i = 0; i < a.length / 2; i++) {
            t = a[i];
            a[i] = a[a.length - i - 1];
            a[a.length - i - 1] = t;
        }
        return a;
    }   

    function remove(address[] storage a, uint256 num) internal returns (address[] memory) {
        
        for (uint i = num; i < a.length-1 ; i++) {
            a[i] = a[i+1];            
        }
        a.pop();
        return a;
    }

    function shift(address[] storage array) internal returns (address[] storage) {
        array=reverse(array);
        array.pop();
        array=reverse(array);
        return array;
    }

}

pragma solidity ^0.5.0;
library uintArrayUtils {  
    function sum(uint256[] storage a) internal returns (uint256) {
        uint256 t;
        for (uint256 i=0; i < a.length; i++) {
            t = t + a[i];
        }
        return t;
    }

    function reverse(uint256[] storage a) internal returns (uint256[] storage) {
        uint256 t;
        for (uint256 i = 0; i < a.length / 2; i++) {
            t = a[i];
            a[i] = a[a.length - i - 1];
            a[a.length - i - 1] = t;
        }
        return a;
    }   

    function remove(uint256[] storage a, uint256 num) internal returns (uint256[] memory) {
        for (uint256 i = num; i < a.length-1 ; i++) {
            a[i] = a[i+1];            
        }
        a.pop();
        return a;
    }

    function shift(uint256[] storage array) internal returns (uint256[] storage) {
        array=reverse(array);
        array.pop();
        array=reverse(array);
        return array;
    }
}

pragma solidity ^0.5.0;

/**
 * @title Roles
 * @dev Library for managing addresses assigned to a Role.
 */
library Roles {
    struct Role {
        mapping (address => bool) bearer;
    }

    /**
     * @dev Give an account access to this role.
     */
    function add(Role storage role, address account) internal {
        require(!has(role, account), "Roles: account already has role");
        role.bearer[account] = true;
    }

    /**
     * @dev Remove an account's access to this role.
     */
    function remove(Role storage role, address account) internal {
        require(has(role, account), "Roles: account does not have role");
        role.bearer[account] = false;
    }

    /**
     * @dev Check if an account has this role.
     * @return bool
     */
    function has(Role storage role, address account) internal view returns (bool) {
        require(account != address(0), "Roles: account is the zero address");
        return role.bearer[account];
    }
}

pragma solidity ^0.5.0;


contract MinterRole {
    using Roles for Roles.Role;

    event MinterAdded(address indexed account);
    event MinterRemoved(address indexed account);

    Roles.Role private _minters;

    constructor () internal {
        _addMinter(msg.sender);
    }

    modifier onlyMinter() {
        require(isMinter(msg.sender), "MinterRole: caller does not have the Minter role");
        _;
    }

    function isMinter(address account) public view returns (bool) {
        return _minters.has(account);
    }

    function addMinter(address account) public onlyMinter {
        _addMinter(account);
    }

    function renounceMinter() public {
        _removeMinter(msg.sender);
    }

    function _addMinter(address account) internal {
        _minters.add(account);
        emit MinterAdded(account);
    }

    function _removeMinter(address account) internal {
        _minters.remove(account);
        emit MinterRemoved(account);
    }
}

pragma solidity ^0.5.0;

/**
 * @dev Interface of the KIP-13 standard, as defined in the
 * [KIP-13](http://kips.klaytn.com/KIPs/kip-13-interface_query_standard).
 *
 * Implementers can declare support of contract interfaces, which can then be
 * queried by others.
 *
 * For an implementation, see `KIP13`.
 */
interface IKIP13 {
    /**
     * @dev Returns true if this contract implements the interface defined by
     * `interfaceId`. See the corresponding
     * [KIP-13 section](http://kips.klaytn.com/KIPs/kip-13-interface_query_standard#how-interface-identifiers-are-defined)
     * to learn more about how these ids are created.
     *
     * This function call must use less than 30 000 gas.
     */
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
}


pragma solidity ^0.5.0;

/**
 * @dev Implementation of the `IKIP13` interface.
 *
 * Contracts may inherit from this and call `_registerInterface` to declare
 * their support of an interface.
 */
contract KIP13 is IKIP13 {
    /*
     * bytes4(keccak256('supportsInterface(bytes4)')) == 0x01ffc9a7
     */
    bytes4 private constant _INTERFACE_ID_KIP13 = 0x01ffc9a7;

    /**
     * @dev Mapping of interface ids to whether or not it's supported.
     */
    mapping(bytes4 => bool) private _supportedInterfaces;

    constructor () internal {
        // Derived contracts need only register support for their own interfaces,
        // we register support for KIP13 itself here
        _registerInterface(_INTERFACE_ID_KIP13);
    }

    /**
     * @dev See `IKIP13.supportsInterface`.
     *
     * Time complexity O(1), guaranteed to always use less than 30 000 gas.
     */
    function supportsInterface(bytes4 interfaceId) external view returns (bool) {
        return _supportedInterfaces[interfaceId];
    }

    /**
     * @dev Registers the contract as an implementer of the interface defined by
     * `interfaceId`. Support of the actual KIP13 interface is automatic and
     * registering its interface id is not required.
     *
     * See `IKIP13.supportsInterface`.
     *
     * Requirements:
     *
     * - `interfaceId` cannot be the KIP13 invalid interface (`0xffffffff`).
     */
    function _registerInterface(bytes4 interfaceId) internal {
        require(interfaceId != 0xffffffff, "KIP13: invalid interface id");
        _supportedInterfaces[interfaceId] = true;
    }
}

// SPDX-License-Identifier: MIT

pragma solidity ^0.5.2;

/**
 * @dev Required interface of an KIP37 compliant contract, as defined in the
 * https://kips.klaytn.com/KIPs/kip-37
 */
contract IKIP37 is IKIP13 {
    /**
     * @dev Emitted when `value` tokens of token type `id` are transfered from `from` to `to` by `operator`.
     */
    event TransferSingle(
        address indexed operator,
        address indexed from,
        address indexed to,
        uint256 id,
        uint256 value
    );


    /**
     * @dev Emitted when `account` grants or revokes permission to `operator` to transfer their tokens, according to
     * `approved`.
     */
    event ApprovalForAll(
        address indexed account,
        address indexed operator,
        bool approved
    );

    /**
     * @dev Emitted when the URI for token type `id` changes to `value`, if it is a non-programmatic URI.
     */
    event URI(string value, uint256 indexed id);

    /**
     * @dev Returns the amount of tokens of token type `id` owned by `account`.
     *
     * Requirements:
     *
     * - `account` cannot be the zero address.
     */
    function balanceOf(address account, uint256 id)
        external
        view
        returns (uint256);


    /**
     * @dev Transfers `amount` tokens of token type `id` from `from` to `to`.
     *
     * Emits a {TransferSingle} event.
     *
     * Requirements:
     *
     * - `to` cannot be the zero address.
     * - If the caller is not `from`, it must be have been approved to spend ``from``'s tokens via {setApprovalForAll}.
     * - `from` must have a balance of tokens of type `id` of at least `amount`.
     * - If `to` refers to a smart contract, it must implement {IKIP37Receiver-onKIP37Received} and return the
     * acceptance magic value.
     */
    function safeTransferFrom(
        address from,
        address to,
        uint256 id,
        uint256 amount,
        bytes calldata data
    ) external;

}

// SPDX-License-Identifier: MIT

pragma solidity ^0.5.0;


/**
 * @dev Interface of the optional KIP37MetadataExtension interface
 */
contract IKIP37MetadataURI is IKIP37 {
    /**
     * @dev Returns the URI for token type `id`.
     *
     * If the `\{id\}` substring is present in the URI, it must be replaced by
     * clients with the actual token type ID.
     */
    function uri(uint256 id) external view returns (string memory);
}

// SPDX-License-Identifier: MIT

pragma solidity ^0.5.0;

contract IERC1155Receiver is IKIP13 {
    /**
        @dev Handles the receipt of a single ERC1155 token type. This function is
        called at the end of a `safeTransferFrom` after the balance has been updated.
        To accept the transfer, this must return
        `bytes4(keccak256("onERC1155Received(address,address,uint256,uint256,bytes)"))`
        (i.e. 0xf23a6e61, or its own function selector).
        @param operator The address which initiated the transfer (i.e. msg.sender)
        @param from The address which previously owned the token
        @param id The ID of the token being transferred
        @param value The amount of tokens being transferred
        @param data Additional data with no specified format
        @return `bytes4(keccak256("onERC1155Received(address,address,uint256,uint256,bytes)"))` if transfer is allowed
    */
    function onERC1155Received(
        address operator,
        address from,
        uint256 id,
        uint256 value,
        bytes calldata data
    ) external returns (bytes4);

}

// SPDX-License-Identifier: MIT

pragma solidity ^0.5.0;

contract IKIP37Receiver is IKIP13 {
    /**
        @dev Handles the receipt of a single KIP37 token type. This function is
        called at the end of a `safeTransferFrom` after the balance has been updated.
        To accept the transfer, this must return
        `bytes4(keccak256("onKIP37Received(address,address,uint256,uint256,bytes)"))`
        (i.e. 0xe78b3325, or its own function selector).
        @param operator The address which initiated the transfer (i.e. msg.sender)
        @param from The address which previously owned the token
        @param id The ID of the token being transferred
        @param value The amount of tokens being transferred
        @param data Additional data with no specified format
        @return `bytes4(keccak256("onKIP37Received(address,address,uint256,uint256,bytes)"))` if transfer is allowed
    */
    function onKIP37Received(
        address operator,
        address from,
        uint256 id,
        uint256 value,
        bytes calldata data
    ) external returns (bytes4);

}

// SPDX-License-Identifier: MIT

pragma solidity ^0.5.0;

/**
 *
 * @dev Implementation of the basic standard multi-token.
 * Originally based on code by Enjin: https://github.com/enjin/erc-1155
 */
contract KIP37 is Context, KIP13, IKIP37, IKIP37MetadataURI, MinterRole {
    using SafeMath for uint256;
    using Address for address;
    using Roles for Roles.Role;

    // Mapping from token ID to account balances
    mapping(uint256 => mapping(address => uint256)) private _balances;

    // Mapping from account to operator approvals
    mapping(address => mapping(address => bool)) private _operatorApprovals;

    // Mapping from token ID to the total supply of the token
    mapping(uint256 => uint256) private _totalSupply;

    // Used as the URI for all token types by relying on ID substition, e.g. https://token-cdn-domain/{id}.json
    string internal _uri;

    /*
     *     bytes4(keccak256('balanceOf(address,uint256)')) == 0x00fdd58e
     *     bytes4(keccak256('balanceOfBatch(address[],uint256[])')) == 0x4e1273f4
     *     bytes4(keccak256('setApprovalForAll(address,bool)')) == 0xa22cb465
     *     bytes4(keccak256('isApprovedForAll(address,address)')) == 0xe985e9c5
     *     bytes4(keccak256('safeTransferFrom(address,address,uint256,uint256,bytes)')) == 0xf242432a
     *     bytes4(keccak256('safeBatchTransferFrom(address,address,uint256[],uint256[],bytes)')) == 0x2eb2c2d6
     *     bytes4(keccak256('totalSupply(uint256)')) == 0xbd85b039
     *
     *     => 0x00fdd58e ^ 0x4e1273f4 ^ 0xa22cb465 ^
     *        0xe985e9c5 ^ 0xf242432a ^ 0x2eb2c2d6 ^ 0xbd85b039 == 0x6433ca1f
     */
    bytes4 private constant _INTERFACE_ID_KIP37 = 0x6433ca1f;

    /*
     *     bytes4(keccak256('uri(uint256)')) == 0x0e89341c
     */
    bytes4 private constant _INTERFACE_ID_KIP37_METADATA_URI = 0x0e89341c;

    bytes4 private constant _INTERFACE_ID_KIP37_TOKEN_RECEIVER = 0x7cc2d017;

    bytes4 private constant _INTERFACE_ID_ERC1155_TOKEN_RECEIVER = 0x4e2312e0;

    // Equals to `bytes4(keccak256("onKIP37Received(address,address,uint256,uint256,bytes)"))`
    // which can be also obtained as `IKIP37Receiver(0).onKIP37Received.selector`
    bytes4 private constant _KIP37_RECEIVED = 0xe78b3325;

    // Equals to `bytes4(keccak256("onERC1155Received(address,address,uint256,uint256,bytes)"))`
    // which can be also obtained as `IERC1155Receiver(0).onERC1155Received.selector`
    bytes4 private constant _ERC1155_RECEIVED = 0xf23a6e61;

    /**
     * @dev See {_setURI}.
     */
    constructor(string memory uri) public {
        _setURI(uri);

        // register the supported interfaces to conform to KIP37 via KIP13
        _registerInterface(_INTERFACE_ID_KIP37);

        // register the supported interfaces to conform to KIP37MetadataURI via KIP13
        _registerInterface(_INTERFACE_ID_KIP37_METADATA_URI);
    }

    /**
     * @dev See {IKIP37MetadataURI-uri}.
     *
     * This implementation returns the same URI for *all* token types. It relies
     * on the token type ID substituion mechanism
     * http://kips.klaytn.com/KIPs/kip-37#metadata
     *
     * Clients calling this function must replace the `\{id\}` substring with the
     * actual token type ID.
     */
    
    // function uri(uint256) external view returns (string memory) {
    //     return _uri;
    // }

    /**
     * @dev See {IKIP37-balanceOf}.
     *
     * Requirements:
     *
     * - `account` cannot be the zero address.
     */
    function balanceOf(address account, uint256 id)
        public
        view
        returns (uint256)
    {
        require(
            account != address(0),
            "KIP37: balance query for the zero address"
        );
        return _balances[id][account];
    }

    /**
     * @dev See {IKIP37-setApprovalForAll}.
     */
    function setApprovalForAll(address operator, bool approved) public {
        require(
            _msgSender() != operator,
            "KIP37: setting approval status for self"
        );

        _operatorApprovals[_msgSender()][operator] = approved;
        emit ApprovalForAll(_msgSender(), operator, approved);
    }

    function setApprovalForAll(address msgSender, address operator, bool approved) public {
        require(
            msgSender != operator,
            "KIP37: setting approval status for self (msg.sender == operator)"
        );

        _operatorApprovals[msgSender][operator] = approved;
        emit ApprovalForAll(msgSender, operator, approved);
    }

    /**
     * @dev See {IKIP37-isApprovedForAll}.
     */
    function isApprovedForAll(address account, address operator)
        public
        view
        returns (bool)
    {
        return _operatorApprovals[account][operator];
    }

    function totalSupply(uint256 _tokenId) public view returns (uint256) {
        return _totalSupply[_tokenId];
    }

    /**
     * @dev See {IKIP37-safeTransferFrom}.
     */
    function safeTransferFrom(
        address from,
        address to,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) public {
        require(to != address(0), "KIP37: transfer to the zero address");
        require(
            from == _msgSender() || isApprovedForAll(from, _msgSender()),
            "KIP37: caller is not owner nor approved"
        );

        // address operator = _msgSender();

        // _beforeTokenTransfer(
        //     operator,
        //     from,
        //     to,
        //     id,
        //     amount,
        //     data
        // );

        _balances[id][from] = _balances[id][from].sub(
            amount,
            "KIP37: insufficient balance for transfer"
        );
        _balances[id][to] = _balances[id][to].add(amount);

        // emit TransferSingle(operator, from, to, id, amount);
        
        // require(
        //     _doSafeTransferAcceptanceCheck(
        //         operator,
        //         from,
        //         to,
        //         id,
        //         amount,
        //         data
        //     ),
        //     "KIP37: transfer to non KIP37Receiver implementer"
        // );
    }
    
    function whoIsMsgSender(address ms) view public returns (address,address) {
        return (ms,_msgSender());
    }

    function onKIP37Received() pure public returns (bytes4) {
        

        return bytes4(keccak256("onKIP37Received(address,address,uint256,uint256,bytes)"));
    }

    /**
     * @dev Sets a new URI for all token types, by relying on the token type ID
     * substituion mechanism
     * http://kips.klaytn.com/KIPs/kip-37#metadata.
     *
     * By this mechanism, any occurence of the `\{id\}` substring in either the
     * URI or any of the amounts in the JSON file at said URI will be replaced by
     * clients with the token type ID.
     *
     * For example, the `https://token-cdn-domain/\{id\}.json` URI would be
     * interpreted by clients as
     * `https://token-cdn-domain/000000000000000000000000000000000000000000000000000000000004cce0.json`
     * for token type ID 0x4cce0.
     *
     * See {uri}.
     *
     * Because these URIs cannot be meaningfully represented by the {URI} event,
     * this function emits no events.
     */
    function _setURI(string memory newuri) internal {
        _uri = newuri;
    }

    /**
     * @dev Creates `amount` tokens of token type `id`, and assigns them to `account`.
     *
     * Emits a {TransferSingle} event.
     *
     * Requirements:
     *
     * - `account` cannot be the zero address.
     * - If `to` refers to a smart contract, it must implement {IKIP37Receiver-onKIP37Received} and return the
     * acceptance magic value.
     */
    function _mint(
        address account,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) internal {
        require(account != address(0), "KIP37: mint to the zero address");

        address operator = _msgSender();

        _beforeTokenTransfer(
            operator,
            address(0),
            account,
            id,
            amount,
            data
        );

        _balances[id][account] = _balances[id][account].add(amount);
        _totalSupply[id] = _totalSupply[id].add(amount);
        emit TransferSingle(operator, address(0), account, id, amount);


        require(
            _doSafeTransferAcceptanceCheck(
                operator,
                address(0),
                account,
                id,
                amount,
                data
            ),
            "KIP37: transfer to non KIP37Receiver implementer"
        );
    }


    /**
     * @dev Destroys `amount` tokens of token type `id` from `account`
     *
     * Requirements:
     *
     * - `account` cannot be the zero address.
     * - `account` must have at least `amount` tokens of token type `id`.
     */
    function _burn(
        address account,
        uint256 id,
        uint256 amount
    ) internal {
        require(account != address(0), "KIP37: burn from the zero address");

        address operator = _msgSender();

        _beforeTokenTransfer(
            operator,
            account,
            address(0),
            id,
            amount,
            ""
        );

        _balances[id][account] = _balances[id][account].sub(
            amount,
            "KIP37: burn amount exceeds balance"
        );

        _totalSupply[id] = _totalSupply[id].sub(
            amount,
            "KIP37: burn amount exceeds total supply"
        );

        emit TransferSingle(operator, account, address(0), id, amount);
    }


    /**
     * @dev Hook that is called before any token transfer. This includes minting
     * and burning, as well as batched variants.
     *
     * The same hook is called on both single and batched variants. For single
     * transfers, the length of the `id` and `amount` arrays will be 1.
     *
     * Calling conditions (for each `id` and `amount` pair):
     *
     * - When `from` and `to` are both non-zero, `amount` of ``from``'s tokens
     * of token type `id` will be  transferred to `to`.
     * - When `from` is zero, `amount` tokens of token type `id` will be minted
     * for `to`.
     * - when `to` is zero, `amount` of ``from``'s tokens of token type `id`
     * will be burned.
     * - `from` and `to` are never both zero.
     * - `ids` and `amounts` have the same, non-zero length.
     *
     * To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks].
     */
    function _beforeTokenTransfer(
        address operator,
        address from,
        address to,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) internal {}

    function _doSafeTransferAcceptanceCheck(
        address operator,
        address from,
        address to,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) private returns (bool) {
        bool success;
        bytes memory returndata;

        if (!to.isContract()) {
            return true;
        }

        (success, returndata) = to.call(
            abi.encodeWithSelector(
                _ERC1155_RECEIVED,
                operator,
                from,
                id,
                amount,
                data
            )
        );
        if (
            returndata.length != 0 &&
            abi.decode(returndata, (bytes4)) == _ERC1155_RECEIVED
        ) {
            return true;
        }

        (success, returndata) = to.call(
            abi.encodeWithSelector(
                _KIP37_RECEIVED,
                operator,
                from,
                id,
                amount,
                data
            )
        );
        if (
            returndata.length != 0 &&
            abi.decode(returndata, (bytes4)) == _KIP37_RECEIVED
        ) {
            return true;
        }

        return false;
    }

// INSERTED BURNABLE AND MINTABLE
    // BURNABLE BELOW
/*
     *     bytes4(keccak256('burn(address,uint256,uint256)')) == 0xf5298aca
     *     bytes4(keccak256('burnBatch(address,uint256[],uint256[])')) == 0x6b20c454
     *
     *     => 0xf5298aca ^ 0x6b20c454 == 0x9e094e9e
     */

    // bytes4 private constant _INTERFACE_ID_KIP37_BURNABLE = 0x9e094e9e;

    // constructor() public {
    //     _registerInterface(_INTERFACE_ID_KIP37_BURNABLE);
    // }

    function burn(
        address account,
        uint256 id,
        uint256 value
    ) public {
        require(
            account == _msgSender(),
            "KIP37: caller is not owner nor approved"
        );

        _burn(account, id, value);
    }

    function destruct(
        address account,
        uint256 id
    ) public {
        require(
            account == _msgSender(),
            "KIP37: caller is not owner nor approved"
        );
        uint256 value;
        value=balanceOf(account,id);
        _burn(account, id, value);
        
        renounceCreator(id);
        delete _uris[id];
    }


    // MINTABLE BELOW

/*
     *     bytes4(keccak256('create(uint256,uint256,string)')) == 0x4b068c78
     *     bytes4(keccak256('mint(uint256,address,uint256)')) == 0x836a1040
     *     bytes4(keccak256('mint(uint256,address[],uint256[])')) == 0xcfa84fc1
     *     bytes4(keccak256('mintBatch(address,uint256[],uint256[])')) == 0xd81d0a15
     *
     *     => 0x4b068c78 ^ 0x836a1040 ^ 0xcfa84fc1 ^ 0xd81d0a15 == 0xdfd9d9ec
     */
    // bytes4 private constant _INTERFACE_ID_KIP37_MINTABLE = 0xdfd9d9ec;

    // id => creators
    mapping(uint256 => address) public creators;

    mapping(uint256 => string) _uris;

    // constructor() public {
    //     _registerInterface(_INTERFACE_ID_KIP37_MINTABLE);
    // }

    function _exists(uint256 tokenId) internal view returns (bool) {
        address creator = creators[tokenId];
        return creator != address(0);
    }
    

    function renounceCreator(uint256 id) public {
        _removeCreator(id);
        renounceMinter();
    }

    function _removeCreator(uint256 id) internal {
        delete creators[id];        
    }

    /**
     * @dev See {IKIP37MetadataURI-uri}.
     *
     * This implementation returns the same URI for *all* token types. It relies
     * on the token type ID substituion mechanism
     * http://kips.klaytn.com/KIPs/kip-37#metadata
     *
     * Clients calling this function must replace the `\{id\}` substring with the
     * actual token type ID.
     */
    function uri(uint256 tokenId) external view returns (string memory) {
        string memory customURI = string(_uris[tokenId]);
        if(bytes(customURI).length != 0) {
            return customURI;
        }

        return _uri;
    }

    /// @notice Creates a new token type and assigns _initialSupply to the minter.
    /// @dev Throws if `msg.sender` is not allowed to create.
    ///   Throws if the token id is already used.
    /// @param _id The token id to create.
    /// @param _initialSupply The amount of tokens being minted.
    /// @param _uri The token URI of the created token.
    /// @return A boolean that indicates if the operation was successful.
    function create(
        uint256 _id,
        uint256 _initialSupply,
        string memory _Curi
    ) public onlyMinter returns (bool) {
        require(!_exists(_id), "KIP37: token already created");

        creators[_id] = msg.sender;
        _mint(msg.sender, _id, _initialSupply, "");

        if (bytes(_Curi).length > 0) {
            _uris[_id] = _Curi;
            emit URI(_Curi, _id);
        }
    }

    /// @notice Mints tokens of the specific token type `_id` and assigns the tokens according to the variables `_to` and `_value`.
    /// @dev Throws if `msg.sender` is not allowed to mint.
    ///   MUST emit an event `TransferSingle`.
    /// @param _id The token id to mint.
    /// @param _to The address that will receive the minted tokens.
    /// @param _value The quantity of tokens being minted.
    function mint(
        uint256 _id,
        address _to,
        uint256 _value
    ) public onlyMinter {
        require(_exists(_id), "KIP37: nonexistent token");
        _mint(_to, _id, _value, "");
    }


}

// SPDX-License-Identifier: MIT

// pragma solidity ^0.5.0;

/**
 * @dev Extension of {KIP37} that allows token holders to destroy both their
 * own tokens and those that they have been approved to use.
//  */
// contract KIP37Burnable is KIP37 {
//     /*
//      *     bytes4(keccak256('burn(address,uint256,uint256)')) == 0xf5298aca
//      *     bytes4(keccak256('burnBatch(address,uint256[],uint256[])')) == 0x6b20c454
//      *
//      *     => 0xf5298aca ^ 0x6b20c454 == 0x9e094e9e
//      */
//     bytes4 private constant _INTERFACE_ID_KIP37_BURNABLE = 0x9e094e9e;

//     constructor() public {
//         _registerInterface(_INTERFACE_ID_KIP37_BURNABLE);
//     }

//     function burn(
//         address account,
//         uint256 id,
//         uint256 value
//     ) public {
//         require(
//             account == _msgSender(),
//             "KIP37: caller is not owner nor approved"
//         );

//         _burn(account, id, value);
//     }

//     // function destruct(
//     //     address account,
//     //     uint256 id
//     // ) public {
//     //     require(
//     //         account == _msgSender(),
//     //         "KIP37: caller is not owner nor approved"
//     //     );
//     //     uint256 value;
//     //     value=balanceOf(account,id);
//     //     _burn(account, id, value);
//     //     MinterRole.renounceMinter();
//     //     KIP37Mintable.renounceCreator(id); // ?????? ????????? ??????
//     // }
 
// }



// pragma solidity ^0.5.0;


// /**
//  * @dev Extension of {KIP37} that allows token holders to destroy both their
//  * own tokens and those that they have been approved to use.
//  */
// contract KIP37Mintable is KIP37, MinterRole {
//     /*
//      *     bytes4(keccak256('create(uint256,uint256,string)')) == 0x4b068c78
//      *     bytes4(keccak256('mint(uint256,address,uint256)')) == 0x836a1040
//      *     bytes4(keccak256('mint(uint256,address[],uint256[])')) == 0xcfa84fc1
//      *     bytes4(keccak256('mintBatch(address,uint256[],uint256[])')) == 0xd81d0a15
//      *
//      *     => 0x4b068c78 ^ 0x836a1040 ^ 0xcfa84fc1 ^ 0xd81d0a15 == 0xdfd9d9ec
//      */
//     bytes4 private constant _INTERFACE_ID_KIP37_MINTABLE = 0xdfd9d9ec;

//     // id => creators
//     mapping(uint256 => address) public creators;

//     mapping(uint256 => string) _uris;

//     constructor() public {
//         _registerInterface(_INTERFACE_ID_KIP37_MINTABLE);
//     }

//     function _exists(uint256 tokenId) internal view returns (bool) {
//         address creator = creators[tokenId];
//         return creator != address(0);
//     }
    

//     function renounceCreator(uint256 id) public {
//         _removeCreator(id);
//     }

//     function _removeCreator(uint256 id) internal {
//         delete creators[id];        
//     }

//     /**
//      * @dev See {IKIP37MetadataURI-uri}.
//      *
//      * This implementation returns the same URI for *all* token types. It relies
//      * on the token type ID substituion mechanism
//      * http://kips.klaytn.com/KIPs/kip-37#metadata
//      *
//      * Clients calling this function must replace the `\{id\}` substring with the
//      * actual token type ID.
//      */
//     function uri(uint256 tokenId) external view returns (string memory) {
//         string memory customURI = string(_uris[tokenId]);
//         if(bytes(customURI).length != 0) {
//             return customURI;
//         }

//         return _uri;
//     }

//     /// @notice Creates a new token type and assigns _initialSupply to the minter.
//     /// @dev Throws if `msg.sender` is not allowed to create.
//     ///   Throws if the token id is already used.
//     /// @param _id The token id to create.
//     /// @param _initialSupply The amount of tokens being minted.
//     /// @param _uri The token URI of the created token.
//     /// @return A boolean that indicates if the operation was successful.
//     function create(
//         uint256 _id,
//         uint256 _initialSupply,
//         string memory _uri
//     ) public onlyMinter returns (bool) {
//         require(!_exists(_id), "KIP37: token already created");

//         creators[_id] = msg.sender;
//         _mint(msg.sender, _id, _initialSupply, "");

//         if (bytes(_uri).length > 0) {
//             _uris[_id] = _uri;
//             emit URI(_uri, _id);
//         }
//     }

//     /// @notice Mints tokens of the specific token type `_id` and assigns the tokens according to the variables `_to` and `_value`.
//     /// @dev Throws if `msg.sender` is not allowed to mint.
//     ///   MUST emit an event `TransferSingle`.
//     /// @param _id The token id to mint.
//     /// @param _to The address that will receive the minted tokens.
//     /// @param _value The quantity of tokens being minted.
//     function mint(
//         uint256 _id,
//         address _to,
//         uint256 _value
//     ) public onlyMinter {
//         require(_exists(_id), "KIP37: nonexistent token");
//         _mint(_to, _id, _value, "");
//     }


// }

pragma solidity ^0.5.0;
contract Test {
    using uintArrayUtils for uint256[];
    using addressArrayUtils for address[];
    using SafeMath for uint256;
        
    uint256[] array;
    address[] _sellers;

    function appendArray(uint256 amount, address seller) public {
        array.push(amount);
        appendSeller(seller);        
    }

    function shiftArray() public {
        array.shift();
    }
   

    function removeArray(uint256 idx) public {        
        require(idx<array.length,"removeArray Error : Index Out of Range");
        array.remove(idx);
        removeSeller(idx);
    }

    function subArray(uint256 num) public {
        if (num<array[0]) {
            array[0]=array[0].sub(num);
        } else {
            if (array.length==1) {
                array.shift();
                removeSeller(0);
                // buyNFT quantity remains!
            } else {
                num=num.sub(array[0]);
                array.shift();
                removeSeller(0);
                subArray(num);
            }
        }
        
    }

    function getArray() view public returns (uint256[] memory) {
        return array;
    }

    function appendSeller(address seller) public {
        _sellers.push(seller);
    }

    function removeSeller(uint256 idx) public {
        require(idx<array.length+1,"removeSeller Error : Index Out of Range");
        _sellers.remove(idx);
    }

    function getSeller() view public returns (address[] memory) {
        return _sellers;
    }
}

pragma solidity ^0.5.0;
contract NFTMarket {
    using uintArrayUtils for uint256[];
    using addressArrayUtils for address[];
    using SafeMath for uint256;

    // NEED TO DEVELOP BELOW
    mapping (uint256 => mapping(uint256 => address[])) mapSellers;  // id => sellPrice => seller's address
    mapping (uint256 => mapping(uint256 => uint256[])) mapQueue;    // id => sellPrice => token amount ready to be sold

    function approveMarket(address KIP37Address) public {
        KIP37Token(KIP37Address).setApprovalForAll(msg.sender, address(this),true);
    }

    function sellNFT(uint256 tokenId, uint256 amount, address KIP37Address, uint256 sellPrice) public returns (bool) {
        approveMarket(KIP37Address);
        appendQueue(tokenId, sellPrice, amount, msg.sender);
        
        KIP37Token(KIP37Address).safeTransferFrom(msg.sender,address(this), tokenId, amount, "0x00");
        return true;
    }
    
    function buyNFT(uint256 tokenId, uint256 amount, address KIP37Address, uint256 buyPrice) public payable returns (bool) {
        
        // 10**18 PEB = 1 Klay
        require( mapQueue[tokenId][buyPrice].length > 0, "No tokens are on the market with that price.");
        require(amount <= mapQueue[tokenId][buyPrice].sum(), "Requested purchase amount exceeds total amount supplied");
        
        require(msg.sender.balance >= buyPrice*amount,"Not enough KLAY");
        
        
        KIP37Token(KIP37Address).safeTransferFrom(address(this), msg.sender, tokenId, amount, "0x00");
        
        // calculate mapSellers and mapQueue, transfer KLAY to sellers
        clearMarket(tokenId, buyPrice, amount);
        return true;
    }

    //  yet to develop
    // function cancelSellNFT(utin256 tokenId, uint256 sellPrice, uint256 amount) public {

    // }

    // Functions to manage mapSellers and mapQueue are BELOW
    function appendQueue(uint256 tokenId, uint256 sellPrice, uint256 amount, address seller) internal {
        mapQueue[tokenId][sellPrice].push(amount);
        _appendSeller(tokenId, sellPrice, seller);        
    }

    function removeQueue(uint256 tokenId, uint256 sellPrice, uint256 idx) internal {        
        require(idx<mapQueue[tokenId][sellPrice].length,"removeArray Error : Index Out of Range");
        mapQueue[tokenId][sellPrice].remove(idx);
        _removeSeller(tokenId, sellPrice, idx);
    }

    function clearMarket(uint256 tokenId, uint256 sellPrice, uint256 num) public payable {
        if ( num <= mapQueue[tokenId][sellPrice][0] ) {
            mapQueue[tokenId][sellPrice][0] = mapQueue[tokenId][sellPrice][0].sub(num);

            address payable target = address(uint160(mapSellers[tokenId][sellPrice][0]));
            (bool sent, ) = target.call.value(sellPrice*num)("");
            require(sent, "Failed to send KLAY");

            if ( mapQueue[tokenId][sellPrice][0] == 0 ) {
                removeQueue(tokenId, sellPrice, 0);
            }
        } else {
            num = num.sub(mapQueue[tokenId][sellPrice][0]);

            address payable target = address(uint160(mapSellers[tokenId][sellPrice][0]));
            (bool sent, ) = target.call.value(sellPrice*mapQueue[tokenId][sellPrice][0])("");
            require(sent, "Failed to send KLAY");

            removeQueue(tokenId, sellPrice, 0);
            clearMarket(tokenId, sellPrice, num);
            }
    }
    

    function getQueue(uint256 tokenId, uint256 sellPrice) view public returns (uint256[] memory) {
        return mapQueue[tokenId][sellPrice];
    }

    function _appendSeller(uint256 tokenId, uint256 sellPrice, address seller) internal {
        mapSellers[tokenId][sellPrice].push(seller);
    }

    function _removeSeller(uint256 tokenId, uint256 sellPrice, uint256 idx) internal {
        require( idx < mapSellers[tokenId][sellPrice].length + 1, "removeSeller Error : Index Out of Range" );
        mapSellers[tokenId][sellPrice].remove(idx);
    }

    function getSeller(uint256 tokenId, uint256 sellPrice) view public returns (address[] memory) {
        return mapSellers[tokenId][sellPrice];
    }
    
}

pragma solidity ^0.5.0;

contract KIP37Token is KIP37 {
    constructor(string memory uri) public KIP37(uri) {}
}


