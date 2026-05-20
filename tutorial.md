# Cloud Networking Observability Skill Walkthrough

Learn how to extend **Gemini CLI** with the **Google Cloud Networking Observability** skill and watch the agent perform real-world network diagnostics directly in your terminal.

---

## Step 1: Introduction
The **Google Cloud Networking Observability** skill gives Gemini CLI specialized instructions to:
* Query and pivot VPC Flow Logs in BigQuery.
* Analyze Firewall Logs to find blocked traffic.
* Create and check Network Management Connectivity Tests.
* Query Cloud NAT metrics and connection logs.

In this walkthrough, you will install the CLI, link this skill, and run live prompts to see the agent in action.

---

## Step 2: Setup Environment
Run the following script to verify your environment, install Gemini CLI, link the Networking skill, and enable auto-approval policies for a seamless experience:

```sh
chmod +x ./verify-env.sh && ./verify-env.sh
```

---

## Step 3: Run a Live Diagnostic Prompt
Now, let's run a real-world network analysis prompt. The agent will use your credentials to run `gcloud` commands and Network Management Connectivity Tests against the project you set in Step 2.

### Prompt: Pairwise VM Connectivity Matrix
Ask the agent to list up to 3 VMs in your project and run a connectivity test between every pair:

```sh
gemini "List up to 3 VMs in my default project. Then run a Network Management connectivity test between every ordered pair of those VMs (skip self-pairs). Present the results as a nicely formatted table with the columns: Source, Destination, Connection Status, and Reason (leave blank if reachable; otherwise explain why it failed)."
```

---

## Step 4: Observe the Agent's Behavior
While the agent is running, watch its terminal output closely. You will see:

1. **Skill Activation:** The agent recognizes the task matches the linked skill and loads its instructions.
2. **Tool Selection:** The agent automatically decides to use BigQuery or Cloud Logging.
3. **Command Generation:** The agent drafts and executes `gcloud` or `bq` commands to query logs.
4. **Reasoning Loop:** The agent parses the output, pivots the data, and continues its investigation until it finds the answer.

---

## Step 5: Clean Up (Optional)
If you want to unlink the skill from your workspace:

```sh
gemini skills uninstall google-cloud-networking-observability
```
