**GOAL:** Generate a complete, multi-file SwiftUI iOS application for a modern Mobile Banking Prototype. The prototype must include functional inter-account fund transfers with input validation and **real-time balance and activity feed updates**.

**TECHNOLOGY & CONSTRAINTS:**
1.  **Language/Framework:** SwiftUI (iOS 17+ compatible).
2.  **Data Management:** Account data and **Transaction Data** must be managed by a single **`@Observable class`** (e.g., `AccountManager`) which is injected into the SwiftUI environment to enable **real-time updates** across views.
3.  **File Structure:** The code must be cleanly separated into multiple Swift files for each major view/model.
4.  **Data Persistence:** Mock data only.

**CORE FUNCTIONALITY & SCREENS (The 5-Tab Structure):**
The app must be structured around a `TabView` with five distinct tags (0 through 4):

| Tab Index | Screen/File | Required Functionality |
| :---: | :--- | :--- |
| **0** | **HomeView.swift** | Displays Total Balance and Account List, dynamically pulled from the `@Observable AccountManager`. |
| **1** | **TransactionsView.swift** | **CRITICAL:** Displays the live transaction list from the `AccountManager`. New transfer entries must appear at the top immediately upon successful transfer. |
| **2** | **TransferView.swift** | Implements the transfer logic, updates the `AccountManager`'s balances, and **triggers transaction logging**. |
| **3** | **CardsView.swift** | Horizontally scrollable view of mock Credit/Debit Cards. |
| **4** | **MoreView.swift** | Simple `List` view for mock settings/profile links. |

**ENHANCEMENTS & INTERACTIONS (CRITICAL UPDATES):**

1.  **Functional Transfer Logic:**
    * The `AccountManager` must contain a function (`performTransfer`) to handle the mutation of account balances.
    * **Transaction Logging:** Upon successful transfer, `performTransfer` must **log two new entries** to the observable transactions list: a negative entry for the source account and a positive entry for the destination account.
2.  **Transfer Validation & Error Handling:** The transfer must include checks for insufficient funds, invalid amounts, and same-account transfers, displaying an **Alert** upon failure.
3.  **Quick Action Deep Link:** The **"Transfer"** Quick Action in `HomeView` must programmatically set the main `TabView`'s selection to **Index 2 (`TransferView`)**.
4.  **Mobile Check Deposit:** The **"Deposit"** Quick Action button in `HomeView` must present a **Sheet** containing the `DepositCheckView` (which uses `UIViewControllerRepresentable` for camera access).

**AESTHETICS & UX:**
* **Design Theme:** Clean, modern, professional banking theme (Deep Blue `#005691` and gray/white palette).
* **Real-time Feedback:** Balances on the `HomeView` and entries on the `TransactionsView` must update immediately after a successful transfer.

**MOCK DATA STRUCTURE (REQUIRED STRUCTS):**
Define the following Swift structs in a `Models.swift` file: `Account`, `Transaction`, and `Card`.
