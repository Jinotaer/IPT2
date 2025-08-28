<?php
session_start();
include('config/config.php');
include('config/checklogin.php');
check_login();
require_once('partials/_head.php');

// Function to safely get count from database
function getCount($mysqli, $table)
{
  try {
    $ret = "SELECT COUNT(*) AS total FROM $table";
    $stmt = $mysqli->prepare($ret);
    if (!$stmt) {
      throw new Exception("Database error: " . $mysqli->error);
    }
    $stmt->execute();
    $res = $stmt->get_result();
    return $res->fetch_object()->total;
  } catch (Exception $e) {
    error_log("Error in getCount: " . $e->getMessage());
    return 0;
  }
}

//Delete individual item - handles both ICS and PAR items
if (isset($_GET['delete_item']) && isset($_GET['type'])) {
  $item_id = $_GET['delete_item'];
  $type = $_GET['type'];

  // Start transaction
  $mysqli->begin_transaction();

  try {
    if ($type === 'ics') {
      // First get the item_id from ics_items
      $stmt = $mysqli->prepare("SELECT item_id FROM ics_items WHERE ics_item_id = ?");
      $stmt->bind_param('i', $item_id);
      $stmt->execute();
      $result = $stmt->get_result();
      $item_id_to_delete = $result->fetch_object()->item_id;

      // Delete from ics_items
      $stmt = $mysqli->prepare("DELETE FROM ics_items WHERE ics_item_id = ?");
      $stmt->bind_param('i', $item_id);
      $stmt->execute();

      $redirect_url = "dashboard.php";
    } else if ($type === 'par') {
      // First get the item_id from par_items
      $stmt = $mysqli->prepare("SELECT item_id FROM par_items WHERE par_item_id = ?");
      $stmt->bind_param('i', $item_id);
      $stmt->execute();
      $result = $stmt->get_result();
      $item_id_to_delete = $result->fetch_object()->item_id;

      // Delete from par_items
      $stmt = $mysqli->prepare("DELETE FROM par_items WHERE par_item_id = ?");
      $stmt->bind_param('i', $item_id);
      $stmt->execute();

      $redirect_url = "dashboard.php";
    } else {
      throw new Exception("Invalid item type specified");
    }

    // Delete from items
    $stmt = $mysqli->prepare("DELETE FROM items WHERE item_id = ?");
    $stmt->bind_param('i', $item_id_to_delete);
    $stmt->execute();

    // Commit transaction
    $mysqli->commit();
    $success = "Item Deleted Successfully";
    header("refresh:1; url=" . $redirect_url);
  } catch (Exception $e) {
    // Rollback transaction on error
    $mysqli->rollback();
    $err = "Error: " . $e->getMessage();
    header("refresh:1; url=dashboard.php");
  }
}

//Delete record - handles both ICS and PAR records
if (isset($_GET['delete']) && isset($_GET['type'])) {
  $id = $_GET['delete'];
  $type = $_GET['type'];

  // Start transaction
  $mysqli->begin_transaction();

  try {
    if ($type === 'ics') {
      // Get all item_ids from ics_items for this ICS
      $stmt = $mysqli->prepare("SELECT item_id FROM ics_items WHERE ics_id = ?");
      $stmt->bind_param('i', $id);
      $stmt->execute();
      $result = $stmt->get_result();

      // Delete from ics_items first
      $stmt = $mysqli->prepare("DELETE FROM ics_items WHERE ics_id = ?");
      $stmt->bind_param('i', $id);
      $stmt->execute();

      // Delete corresponding items
      while ($row = $result->fetch_object()) {
        $stmt = $mysqli->prepare("DELETE FROM items WHERE item_id = ?");
        $stmt->bind_param('i', $row->item_id);
        $stmt->execute();
      }

      // Delete from inventory_custodian_slips
      $stmt = $mysqli->prepare("DELETE FROM inventory_custodian_slips WHERE ics_id = ?");
      $stmt->bind_param('i', $id);
      $stmt->execute();

      $redirect_url = "dashboard.php";
    } else if ($type === 'par') {
      // Get all item_ids from par_items for this par
      $stmt = $mysqli->prepare("SELECT item_id FROM par_items WHERE par_id = ?");
      $stmt->bind_param('i', $id);
      $stmt->execute();
      $result = $stmt->get_result();

      // Delete from par_items first
      $stmt = $mysqli->prepare("DELETE FROM par_items WHERE par_id = ?");
      $stmt->bind_param('i', $id);
      $stmt->execute();

      // Delete corresponding items
      while ($row = $result->fetch_object()) {
        $stmt = $mysqli->prepare("DELETE FROM items WHERE item_id = ?");
        $stmt->bind_param('i', $row->item_id);
        $stmt->execute();
      }

      // Delete from property_acknowledgment_receipts
      $stmt = $mysqli->prepare("DELETE FROM property_acknowledgment_receipts WHERE par_id = ?");
      $stmt->bind_param('i', $id);
      $stmt->execute();

      $redirect_url = "dashboard.php";
    } else {
      throw new Exception("Invalid record type specified");
    }

    // Commit transaction
    $mysqli->commit();
    $success = "Record Deleted Successfully";
    header("refresh:1; url=" . $redirect_url);
  } catch (Exception $e) {
    // Rollback transaction on error
    $mysqli->rollback();
    $err = "Error: " . $e->getMessage();
    header("refresh:1; url=dashboard.php");
  }
}

// Handle legacy delete requests (for backward compatibility)
if (isset($_GET['delete']) && !isset($_GET['type'])) {
  // Determine type based on referring page or other context
  $id = $_GET['delete'];
  $referer = isset($_SERVER['HTTP_REFERER']) ? $_SERVER['HTTP_REFERER'] : '';

  if (strpos($referer, 'par') !== false || strpos($referer, 'display_par.php') !== false) {
    header("Location: dashboard.php?delete=" . $id . "&type=par");
  } else {
    header("Location: dashboard.php?delete=" . $id . "&type=ics");
  }
  exit;
}

// Handle legacy delete_item requests (for backward compatibility)
if (isset($_GET['delete_item']) && !isset($_GET['type'])) {
  // Determine type based on referring page or other context
  $item_id = $_GET['delete_item'];
  $referer = isset($_SERVER['HTTP_REFERER']) ? $_SERVER['HTTP_REFERER'] : '';

  if (strpos($referer, 'par') !== false || strpos($referer, 'display_par.php') !== false) {
    header("Location: dashboard.php?delete_item=" . $item_id . "&type=par");
  } else {
    header("Location: dashboard.php?delete_item=" . $item_id . "&type=ics");
  }
  exit;
}
?>

<body>
  <!-- Loading Spinner -->
  <div id="loading-spinner" class="loading-spinner">
    <div class="spinner-border text-primary" role="status">
      <span class="sr-only">Loading...</span>
    </div>
  </div>

  <!-- Sidenav -->
  <?php require_once('partials/_sidebar.php'); ?>

  <!-- Main content -->
  <div class="main-content">
    <!-- Top navbar -->
    <?php require_once('partials/_topnav.php'); ?>

    <!-- Header -->
    <div style="background-image: url(assets/img/theme/front.png); background-size: cover; background-position: center;"
      class="header pb-8 pt-5 pt-md-8">
      <span class="mask bg-gradient-dark opacity-8"></span>
      <div class="container-fluid">
        <div class="header-body">
          <!-- Card stats -->
          <div class="row">
            <?php
            $stats = [
              [
                'title' => 'Inspection Acceptance Reports',
                'count' => getCount($mysqli, 'iar_items'),
                'icon' => 'fact_check',
                'color' => 'danger'
              ],
              [
                'title' => 'Inventory Custodian Slip',
                'count' => getCount($mysqli, 'ics_items'),
                'icon' => 'inventory_2',
                'color' => 'primary'
              ],
              [
                'title' => 'Property Acknow - ledgment Receipt',
                'count' => getCount($mysqli, 'par_items'),
                'icon' => 'receipt_long',
                'color' => 'warning'
              ],
              [
                'title' => 'Requisition and Issue Slip',
                'count' => getCount($mysqli, 'ris_items'),
                'icon' => 'request_quote',
                'color' => 'success'
              ]
            ];

            foreach ($stats as $stat) {
            ?>
              <div class="col-xl-3 col-lg-6">
                <div class="card card-stats mb-4 mb-xl-0">
                  <div class="card-body">
                    <div class="row">
                      <div class="col">
                        <h5 class="card-title text-uppercase text-muted mb-0"><?php echo $stat['title']; ?></h5>
                        <span class="h2 font-weight-bold mb-0"><?php echo number_format($stat['count']); ?></span>
                      </div>
                      <div class="col-auto">
                        <div class="icon icon-shape bg-<?php echo $stat['color']; ?> text-white rounded-circle shadow">
                          <i class="material-icons-sharp"><?php echo $stat['icon']; ?></i>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            <?php
            }
            ?>
          </div>
        </div>
      </div>
    </div>

    <!-- Page content -->
    <div class="container-fluid mt--7">
      <div class="row mt-5">
        <div class="col-xl-12 mb-5 mb-xl-0">
          <div class="card shadow">
            <div class="card-header border-0">
              <div class="row align-items-center">
                <div class="col">
                  <h3 class="mb-0">REPORT ON THE PHYSICAL COUNT OF PROPERTY, PLANT AND EQUIPMENT</h3>
                </div>
                <div class="col text-right">
                  <a href="dashboard_seeall_rpcppe.php" class="btn btn-sm btn-primary">
                    <i class="fas fa-eye"></i> See all
                  </a>
                </div>
              </div>
            </div>
            <div class="table-responsive">
              <table id="parTable" class="table align-items-center table-flush">
                <thead class="thead-light">
                  <tr>
                    <th class="text-primary" scope="col">Article</th>
                    <th scope="col">Item Description</th>
                    <th class="text-primary" scope="col">Property No.</th>
                    <th scope="col">Unit</th>
                    <th class="text-primary" scope="col">Unit Value</th>
                    <th scope="col">Quantity</th>
                    <th class="text-primary" scope="col">Total Amount</th>
                    <!-- <th scope="col">Date Acquired</th> -->
                    <th  scope="col">Remarks</th>
                    <!-- <th scope="col">Actions</th> -->
                  </tr>
                </thead>
                <tbody>
                  <?php
                  try {
                    $ret = "SELECT par.par_id as id, par.par_no, par.end_user_name, par.receiver_position, 
                    par.receiver_date, par.date_acquired,
                    i.item_description, i.unit_cost, i.unit,
                    e.entity_name, e.fund_cluster as entity_fund_cluster,
                    pi.quantity, pi.property_number, pi.remarks, pi.article,
                    (pi.quantity * i.unit_cost) as total_amount
                    FROM property_acknowledgment_receipts par
                    LEFT JOIN par_items pi ON par.par_id = pi.par_id
                    LEFT JOIN items i ON pi.item_id = i.item_id
                    LEFT JOIN entities e ON par.entity_id = e.entity_id
                              ORDER BY par.created_at DESC LIMIT 10";
                    $stmt = $mysqli->prepare($ret);
                    if (!$stmt) {
                      throw new Exception("Database error: " . $mysqli->error);
                    }
                    $stmt->execute();
                    $res = $stmt->get_result();
                    while ($par = $res->fetch_object()) {
                  ?>
                      <tr>
                        <td class="text-primary"><?php echo isset($par->article) ? $par->article : ''; ?></td>
                        <td><?php echo isset($par->item_description) ? $par->item_description : ''; ?></td>
                        <td class="text-primary"><?php echo isset($par->property_number) ? $par->property_number : ''; ?></td>
                        <td><?php echo isset($par->unit) ? $par->unit : ''; ?></td>
                        <td class="text-primary"><?php echo isset($par->unit_cost) ? $par->unit_cost : ''; ?></td>
                        <td><?php echo isset($par->quantity) ? $par->quantity : ''; ?></td>
                        <td class="text-primary"><?php echo isset($par->total_amount) ? $par->total_amount : ''; ?></td>
                        <!-- <td><?php echo isset($par->date_acquired) ? $par->date_acquired : ''; ?></td> -->
                        <td><?php echo isset($par->remarks) ? $par->remarks : ''; ?></td>
                        <!-- <td>
                          <a href="dashboard.php?delete=<?php echo $par->par_id; ?>&type=par"
                            onclick="return confirm('Are you sure you want to delete this record?')">
                            <button class="btn btn-sm btn-danger">
                              <i class="fas fa-trash"></i>
                              Delete
                            </button>
                          </a>
                          <?php if (isset($par->par_item_id)): ?>
                          <a href="dashboard.php?delete_item=<?php echo $par->par_item_id; ?>&type=par"
                            onclick="return confirm('Are you sure you want to delete this item?')">
                            <button class="btn btn-sm btn-danger">
                              <i class="fas fa-trash-alt"></i>
                              Delete 
                            </button>
                          </a>
                          <?php endif; ?>
                          <a href="par_update.php?update=<?php echo $par->par_id; ?>">
                            <button class="btn btn-sm btn-primary">
                              <i class="fas fa-user-edit"></i>
                              Update
                            </button>
                          </a>
                        </td> -->
                      </tr>
                  <?php
                    }
                  } catch (Exception $e) {
                    error_log("Error in PAR table: " . $e->getMessage());
                    echo '<tr><td colspan="11" class="text-center text-danger">Error loading data</td></tr>';
                  }
                  ?>
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>

      <div class="row mt-5">
        <div class="col-xl-12">
          <div class="card shadow">
            <div class="card-header border-0">
              <div class="row align-items-center">
                <div class="col">
                  <h3 class="mb-0">REPORT ON THE PHYSICAL COUNT OF SEMI-EXPENDABLE PROPERTY</h3>
                </div>
                <div class="col text-right">
                  <a href="dashboard_seeall_rpcsp.php" class="btn btn-sm btn-primary">
                    <i class="fas fa-eye"></i> See all
                  </a>
                </div>
              </div>
            </div>
            <div class="table-responsive">
              <table class="table align-items-center table-flush">
                <thead class="thead-light">
                  <tr>
                    <th class="text-primary" scope="col">Article</th>
                    <th scope="col">Item Description</th>
                    <th class="text-primary" scope="col">Inventory Item No.</th>
                    <th scope="col">Unit</th>
                    <th class="text-primary" scope="col">Unit Value</th>
                    <th scope="col">Quantity</th>
                    <th class="text-primary" scope="col">Total Amount</th>
                    <th scope="col">Estimated Useful Life</th>
                    <th class="text-primary" scope="col">Remarks</th>
                    <!-- <th scope="col">Actions</th> -->
                  </tr>
                </thead>
                <tbody>
                  <?php
                  try {
                    $ret = "SELECT ics.ics_id as id, ics.ics_no, ics.end_user_name, ics.end_user_position, 
                    ics.end_user_date as date_received_user, ics.custodian_name, ics.custodian_position, 
                    ics.custodian_date as date_received_custodian, ics.created_at,
                    i.item_description, i.unit_cost, i.unit, ii.estimated_useful_life as estimated_life,
                    e.entity_name, e.fund_cluster as entity_fund_cluster,
                    ii.quantity, ii.inventory_item_no, ii.remarks, ii.article,
                    (ii.quantity * i.unit_cost) as total_amount
                    FROM inventory_custodian_slips ics
                    LEFT JOIN ics_items ii ON ics.ics_id = ii.ics_id
                    LEFT JOIN items i ON ii.item_id = i.item_id
                    LEFT JOIN entities e ON ics.entity_id = e.entity_id
                              ORDER BY ics.created_at DESC LIMIT 10";
                    $stmt = $mysqli->prepare($ret);
                    if (!$stmt) {
                      throw new Exception("Database error: " . $mysqli->error);
                    }
                    $stmt->execute();
                    $res = $stmt->get_result();
                    while ($ics = $res->fetch_object()) {
                  ?>
                      <tr>
                        <td class="text-primary"><?php echo isset($ics->article) ? $ics->article : ''; ?></td>
                        <td><?php echo isset($ics->item_description) ? $ics->item_description : ''; ?></td>
                        <td class="text-primary"><?php echo isset($ics->inventory_item_no) ? $ics->inventory_item_no : ''; ?></td>
                        <td><?php echo isset($ics->unit) ? $ics->unit : ''; ?></td>
                        <td class="text-primary"><?php echo isset($ics->unit_cost) ? $ics->unit_cost : ''; ?></td>
                        <td><?php echo isset($ics->quantity) ? $ics->quantity : ''; ?></td>
                        <td class="text-primary"><?php echo isset($ics->total_amount) ? $ics->total_amount : ''; ?></td>
                        <td><?php echo isset($ics->estimated_life) ? $ics->estimated_life : ''; ?></td>
                        <td class="text-primary"><?php echo isset($ics->remarks) ? $ics->remarks : ''; ?></td>
                        <!-- <td>
                          <a href="dashboard.php?delete=<?php echo $ics->ics_id; ?>&type=ics"
                           onclick="return confirm('Are you sure you want to delete this record?')">
                            <button class="btn btn-sm btn-danger">
                              <i class="fas fa-trash"></i>
                              Delete
                            </button>
                          </a>
                          <?php if (isset($ics->ics_item_id)): ?>
                          <a href="dashboard.php?delete_item=<?php echo $ics->ics_item_id; ?>&type=ics"
                            onclick="return confirm('Are you sure you want to delete this item?')">
                            <button class="btn btn-sm btn-danger">
                              <i class="fas fa-trash-alt"></i>
                              Delete  
                            </button>
                          </a>
                          <?php endif; ?>
                          <a href="ics_update.php?update=<?php echo $ics->ics_id; ?>">
                            <button class="btn btn-sm btn-primary">
                              <i class="fas fa-user-edit"></i>
                              Update
                            </button>
                          </a>
                        </td> -->
                      </tr>
                  <?php
                    }
                  } catch (Exception $e) {
                    error_log("Error in ICS table: " . $e->getMessage());
                    echo '<tr><td colspan="9" class="text-center text-danger">Error loading data</td></tr>';
                  }
                  ?>
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>

      <!-- Footer -->
      <?php require_once('partials/_mainfooter.php'); ?>
    </div>
  </div>

  <!-- Argon Scripts -->
  <?php require_once('partials/_scripts.php'); ?>

  <style>
    .loading-spinner {
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: rgba(255, 255, 255, 0.8);
      display: flex;
      justify-content: center;
      align-items: center;
      z-index: 9999;
      display: none;
    }

    .card-stats {
      transition: transform 0.2s;
    }

    .card-stats:hover {
      transform: translateY(-5px);
    }

    .table-responsive {
      max-height: 500px;
      overflow-y: auto;
    }

    .btn-group {
      display: flex;
      gap: 5px;
    }
  </style>

  <script>
    // Show loading spinner when page is loading
    document.addEventListener('DOMContentLoaded', function() {
      const spinner = document.getElementById('loading-spinner');
      spinner.style.display = 'flex';

      // Hide spinner when everything is loaded
      window.addEventListener('load', function() {
        spinner.style.display = 'none';
      });
    });

    // Add smooth scrolling to tables
    document.querySelectorAll('.table-responsive').forEach(table => {
      table.addEventListener('scroll', function() {
        const shadow = this.parentElement;
        if (this.scrollTop > 0) {
          shadow.classList.add('shadow-sm');
        } else {
          shadow.classList.remove('shadow-sm');
        }
      });
    });
  </script>
  <script src="https://cdn.datatables.net/2.2.2/js/dataTables.min.js">
    let table = new DataTable('#parTable');
  </script>
<style>
    /* .table-responsive {
      max-height: 500px;
      overflow-y: auto;
    } */
    /* .btn-group {
      display: flex;
      gap: 5px;
    } */
    tbody tr:hover {
      background-color: #f8f9fa;
    }
  </style>
</body>

</html>