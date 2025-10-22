import 'package:dredge_ui/src/models/country_data.dart';
import 'package:dredge_ui/src/providers/dialog_provider.dart';
import 'package:dredge_ui/src/utils/common.dart';
import 'package:dredge_ui/src/widgets/tappable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class DrPhoneInput extends StatefulWidget {
  final TextEditingController? controller;
  final String? value;
  final ValueChanged<String>? onChange;
  final String? label;
  final bool enabled;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? cursorColor;
  final TextStyle? textStyle;
  final List<String>? availableCountryCodes;

  const DrPhoneInput({
    super.key,
    this.controller,
    this.value,
    this.onChange,
    this.label,
    this.enabled = true,
    this.backgroundColor,
    this.borderColor,
    this.focusedBorderColor,
    this.cursorColor,
    this.textStyle,
    this.availableCountryCodes,
  }) : assert(
         (controller != null) != (value != null && onChange != null),
         'Must provide either controller OR value/onChange, not both',
       );

  @override
  State<DrPhoneInput> createState() => _DrPhoneInputState();
}

class _DrPhoneInputState extends State<DrPhoneInput> {
  late TextEditingController _internalController;
  late TextEditingController _phoneController;
  late FocusNode _focusNode;
  late CountryPhoneData _selectedCountry;
  bool _isLocalDialogVisible = false;

  List<CountryPhoneData> get _countries {
    if (widget.availableCountryCodes != null) {
      return widget.availableCountryCodes!
          .map((code) => countryPhoneDataDictionary[code])
          .whereType<CountryPhoneData>()
          .toList();
    }

    return countries;
  }

  @override
  void initState() {
    super.initState();
    _internalController =
        widget.controller ?? TextEditingController(text: widget.value ?? '');
    _focusNode = FocusNode();

    final parsed = _parsePhoneNumber(_internalController.text);
    _selectedCountry = parsed.country;
    _phoneController = TextEditingController(text: parsed.phoneNumber);

    _internalController.addListener(_onInternalControllerChange);
  }

  void _onInternalControllerChange() {
    final parsed = _parsePhoneNumber(_internalController.text);
    if (parsed.country != _selectedCountry) {
      setState(() {
        _selectedCountry = parsed.country;
      });
    }
    if (_phoneController.text != parsed.phoneNumber) {
      _phoneController.text = parsed.phoneNumber;
    }
  }

  ({CountryPhoneData country, String phoneNumber}) _parsePhoneNumber(
    String fullPhone,
  ) {
    if (fullPhone.isEmpty) {
      return (country: countries.first, phoneNumber: '');
    }

    // Try to match against available countries by dial code
    for (final country in _countries) {
      if (fullPhone.startsWith(country.dialCode)) {
        final phoneNumber = fullPhone.substring(country.dialCode.length);
        return (country: country, phoneNumber: phoneNumber);
      }
    }

    // If no match found, return first country and the full phone
    return (country: countries.first, phoneNumber: fullPhone);
  }

  void _updateFullPhone() {
    final fullPhone = '${_selectedCountry.dialCode}${_phoneController.text}';
    _internalController.text = fullPhone;
    widget.onChange?.call(fullPhone);
  }

  @override
  void didUpdateWidget(DrPhoneInput oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.controller != oldWidget.controller) {
      _internalController.removeListener(_onInternalControllerChange);
      _internalController =
          widget.controller ?? TextEditingController(text: widget.value ?? '');
      _internalController.addListener(_onInternalControllerChange);

      final parsed = _parsePhoneNumber(_internalController.text);
      setState(() {
        _selectedCountry = parsed.country;
      });
      _phoneController.text = parsed.phoneNumber;
    }

    if (widget.controller == null && widget.value != null) {
      final currentFullPhone = _internalController.text;
      if (widget.value != currentFullPhone) {
        _internalController.text = widget.value!;
      }
    }
  }

  @override
  void dispose() {
    _internalController.removeListener(_onInternalControllerChange);
    if (widget.controller == null) {
      _internalController.dispose();
    }
    _phoneController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _showCountrySelector() {
    final dialogProvider = context.read<DialogProvider>();

    setState(() {
      _isLocalDialogVisible = true;
    });

    dialogProvider.openDialog(
      SimpleDialog(
        title: const Text('Select Country'),
        children: _countries.map((country) {
          return SimpleDialogOption(
            onPressed: () {
              setState(() {
                _selectedCountry = country;
                _isLocalDialogVisible = false;
              });
              _updateFullPhone();
              dialogProvider.closeDialog();
            },
            child: Row(
              children: [
                Text(country.flag, style: const TextStyle(fontSize: 24)),
                const SizedBox(width: 12),
                Text(
                  country.dialCode,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    country.name,
                    style: const TextStyle(fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dialogProvider = context.watch<DialogProvider>();

    return Stack(
      children: [
        Container(
          height: 52,
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            border: widget.backgroundColor != null
                ? null
                : Border.all(
                    color:
                        widget.borderColor ??
                        (_focusNode.hasFocus
                            ? (widget.focusedBorderColor ?? const Color(0xFF007AFF))
                            : Colors.grey.shade400),
                    width: _focusNode.hasFocus ? 2 : 1,
                  ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        Positioned.fill(
          child: Row(
            children: [
              Tappable(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
                onTap: let(
                  widget.enabled,
                  (enabled) =>
                      () => _showCountrySelector(),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      Text(
                        _selectedCountry.flag,
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _selectedCountry.dialCode,
                        style: TextStyle(
                          color: Colors.black,
                        ).merge(widget.textStyle),
                      ),
                      if (widget.enabled)
                        Icon(
                          (dialogProvider.isDialogVisible &&
                                  _isLocalDialogVisible)
                              ? Icons.arrow_drop_up
                              : Icons.arrow_drop_down,
                          size: 20,
                          color: Colors.grey,
                        ),
                    ],
                  ),
                ),
              ),
              Container(width: 1, height: 32, color: Colors.grey.shade300),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        autocorrect: false,
                        enableSuggestions: false,
                        controller: _phoneController,
                        focusNode: _focusNode,
                        onChanged: (value) {
                          _updateFullPhone();
                        },
                        enabled: widget.enabled,
                        keyboardType: TextInputType.phone,
                        style: widget.textStyle,
                        cursorColor: widget.cursorColor,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 16,
                          ),
                          hintText: 'Phone number',
                        ),
                      ),
                    ),
                    if (!widget.enabled)
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Icon(Icons.lock, size: 20, color: Colors.grey),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (widget.label != null)
          Positioned(
            left: 12,
            top: -8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              color: widget.backgroundColor ?? Colors.white,
              child: Text(
                widget.label!,
                style:
                    widget.textStyle?.copyWith(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ) ??
                    TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ),
          ),
      ],
    );
  }
}
