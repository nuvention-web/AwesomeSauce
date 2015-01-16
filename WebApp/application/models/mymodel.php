ass Blogmodel extends CI_Model {

    var $title   = '';
    var $content = '';
    var $date    = '';

    function __construct()
    {
        // Call the Model constructor
        parent::__construct();
    }
    
    function getAllEmails()
    {
	$query = $this->db->get('potential_emails');
	return $query->result();
    }

    function insertPotentialEmail($email, $first=NULL,$last=NULL)
    {
	$data['email'] = $email;
	$data['firstname'] = $first;
	$data['lastname'] = $last;

	$this->db->insert('potential_emails',$data);
    }
}
