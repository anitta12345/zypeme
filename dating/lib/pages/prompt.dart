import 'package:flutter/material.dart';

class PromptSelectionScreen extends StatefulWidget {
  const PromptSelectionScreen({Key? key}) : super(key: key);

  @override
  State<PromptSelectionScreen> createState() => _PromptSelectionScreenState();
}

class _PromptSelectionScreenState extends State<PromptSelectionScreen> {
  final TextEditingController _controller = TextEditingController();
  String? selectedPrompt;

  final List<String> prompts = [
    "My favorite recent photo of myself.",
    "The smile that says I’m ready to meet someone new.",
    "This is me on a day I felt confident",
    "This is the version of me I’d want you to meet first",
    "A snapshot of me when I felt completely at ease.",
    "A moment that made me feel truly myself.",
    "The photo that best captures my energy.",
    "Me, just being me — no filters",
    "The kind of day I’d love to share with someone.",
    "This is how I look when I’m happiest",
  ];

  void _confirmPrompt() {
    final input = _controller.text.trim();
    Navigator.pop(context, input.isNotEmpty ? input : selectedPrompt);
    print("object: $input");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top Icons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back, size: 28),
                  ),
                  GestureDetector(
                    onTap: _confirmPrompt,
                    child: const Icon(Icons.check, size: 28),
                  ),
                ],
              ),
            ),

            // Text Field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: "Enter Your Own...",
                  hintStyle: const TextStyle(
                    color: Color.fromARGB(255, 223, 221, 221),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: const Color.fromARGB(255, 223, 221, 221),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Prompt list (non-scrollable, adjusts with keyboard)
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final keyboardHeight =
                      MediaQuery.of(context).viewInsets.bottom;
                  final availableHeight =
                      constraints.maxHeight - keyboardHeight;

                  return SizedBox(
                    height: availableHeight,
                    child: ListView.builder(
                      physics:
                          const NeverScrollableScrollPhysics(), // disables scroll
                      itemCount: prompts.length,
                      itemBuilder: (context, index) {
                        final prompt = prompts[index];
                        final isSelected = selectedPrompt == prompt;
                        return Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Container(
                            color:
                                isSelected
                                    ? const Color(0xFFFFF0F6)
                                    : Colors.transparent,
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: const Icon(
                                Icons.circle,
                                size: 10,
                                color: Colors.pinkAccent,
                              ),
                              title: Text(prompt),
                              onTap: () {
                                setState(() {
                                  selectedPrompt = prompt;
                                  _controller.clear();
                                });
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
